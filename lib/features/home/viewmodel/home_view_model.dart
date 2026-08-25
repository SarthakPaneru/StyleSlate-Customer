import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/appointments/appointment_repository.dart';
import 'package:hamro_barber_mobile/data/appointments/models/appointment_model.dart';
import 'package:hamro_barber_mobile/data/barbers/barber_repository.dart';
import 'package:hamro_barber_mobile/data/barbers/models/nearest_barber_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._repository, this._appointmentRepository);

  final BarberRepository _repository;
  final AppointmentRepository _appointmentRepository;

  ViewStatus status = ViewStatus.loading;
  String? errorMessage;
  double latitude = 0;
  double longitude = 0;

  /// Human-readable "City, Region" for [latitude]/[longitude], resolved via
  /// reverse geocoding and cached across launches so it can show instantly
  /// next time instead of raw coordinates or a "Locating..." placeholder.
  String placeName = '';
  List<NearestBarberModel> barbers = const [];

  /// One most-recent completed appointment per barber the customer has
  /// actually visited before, for the "Book Again" section. Empty for a
  /// new customer with no history -- the section just doesn't show, same
  /// as a real "reorder" shelf in a food-delivery app.
  List<AppointmentModel> recentBarbers = const [];

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 0;
    longitude = prefs.getDouble('longitude') ?? 0;
    placeName = prefs.getString('placeName') ?? '';
    notifyListeners();

    await _refreshLocation(prefs);
    await _resolvePlaceName(prefs);
    await loadBarbers();
    unawaited(_loadRecentBarbers());
  }

  // ==========================================================================
  // TEMPORARY -- DEBUG-ONLY MOCK DATA for design review.
  // Lets "Book Again" and "Recommended Barbers" be previewed on accounts/
  // areas with no real data yet. Only ever used when the real list comes
  // back empty AND kDebugMode is true, so it can never appear in a release
  // build. DO NOT remove until told to -- kept for UI review on request.
  // ==========================================================================
  static const _mockRecentBarbers = [
    AppointmentModel(
      bookingStart: 0,
      barberId: 9001,
      barberUserId: 9001,
      barberName: 'Prajwal Shrestha',
      serviceName: 'Haircut',
    ),
    AppointmentModel(
      bookingStart: 0,
      barberId: 9002,
      barberUserId: 9002,
      barberName: 'Sagar Thapa',
      serviceName: 'Beard Trim',
    ),
    AppointmentModel(
      bookingStart: 0,
      barberId: 9003,
      barberUserId: 9003,
      barberName: 'Bikash Gurung',
      serviceName: 'Hair Styling',
    ),
  ];

  static const _mockNearbyBarbers = [
    NearestBarberModel(
      id: 9001,
      distance: 1.2,
      user: NearestBarberUser(
          id: 9001, firstName: 'Prajwal', lastName: 'Shrestha'),
    ),
    NearestBarberModel(
      id: 9002,
      distance: 2.8,
      user: NearestBarberUser(id: 9002, firstName: 'Sagar', lastName: 'Thapa'),
    ),
    NearestBarberModel(
      id: 9003,
      distance: 0.6,
      user: NearestBarberUser(
          id: 9003, firstName: 'Bikash', lastName: 'Gurung'),
    ),
    NearestBarberModel(
      id: 9004,
      distance: 3.4,
      user: NearestBarberUser(
          id: 9004, firstName: 'Anish', lastName: 'Karki'),
    ),
  ];

  Future<void> _loadRecentBarbers() async {
    try {
      final completed = await _appointmentRepository.getAppointments('completed');
      final sorted = [...completed]
        ..sort((a, b) => b.bookingStart.compareTo(a.bookingStart));

      final seenBarberIds = <int>{};
      final deduped = <AppointmentModel>[];
      for (final appointment in sorted) {
        if (seenBarberIds.add(appointment.barberId)) {
          deduped.add(appointment);
        }
        if (deduped.length >= 6) break;
      }

      // TODO(remove-before-production): drop this fallback (and
      // _mockRecentBarbers above) -- see the banner comment above it.
      recentBarbers =
          deduped.isNotEmpty ? deduped : (kDebugMode ? _mockRecentBarbers : deduped);
      notifyListeners();
    } on AppException {
      // "Book Again" is a nice-to-have, not core functionality -- if it
      // fails to load, the section just stays hidden rather than showing
      // an error state for something the user didn't explicitly ask for.
    }
  }

  Future<void> _refreshLocation(SharedPreferences prefs) async {
    // Instant, no-GPS-wait position the OS already has cached -- shows up
    // sooner than waiting on the fresh fix requested below, and often
    // sooner than our own SharedPreferences cache on a cold start.
    try {
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        latitude = lastKnown.latitude;
        longitude = lastKnown.longitude;
        notifyListeners();
      }
    } catch (_) {
      // Fall through to requesting a fresh fix below.
    }

    try {
      await Geolocator.requestPermission();
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      await prefs.setDouble('latitude', latitude);
      await prefs.setDouble('longitude', longitude);
      notifyListeners();
    } catch (_) {
      // Fall back to whatever was already loaded above.
    }
  }

  Future<void> _resolvePlaceName(SharedPreferences prefs) async {
    if (latitude == 0 && longitude == 0) return;

    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) return;

      final placemark = placemarks.first;
      final parts = [placemark.locality, placemark.administrativeArea]
          .where((part) => part != null && part.trim().isNotEmpty)
          .toList();
      final resolved =
          parts.isNotEmpty ? parts.join(', ') : (placemark.country ?? '');
      if (resolved.isEmpty) return;

      placeName = resolved;
      await prefs.setString('placeName', placeName);
      notifyListeners();
    } catch (_) {
      // Keep whichever cached placeName was already loaded above (if any)
      // rather than showing raw coordinates or crashing.
    }
  }

  Future<void> loadBarbers() async {
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final nearest = await _repository.getNearestBarbers(
        latitude: latitude,
        longitude: longitude,
      );
      // TODO(remove-on-request): drop this fallback (and _mockNearbyBarbers
      // above) -- see the banner comment above it.
      barbers =
          nearest.isNotEmpty ? nearest : (kDebugMode ? _mockNearbyBarbers : nearest);
      status = ViewStatus.success;
    } on AppException catch (e) {
      status = ViewStatus.error;
      errorMessage = e.message;
    }
    notifyListeners();
  }
}
