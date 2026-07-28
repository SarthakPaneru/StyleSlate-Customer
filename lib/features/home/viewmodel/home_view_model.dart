import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/barbers/barber_repository.dart';
import 'package:hamro_barber_mobile/data/barbers/models/nearest_barber_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._repository);

  final BarberRepository _repository;

  ViewStatus status = ViewStatus.loading;
  String? errorMessage;
  double latitude = 0;
  double longitude = 0;

  /// Human-readable "City, Region" for [latitude]/[longitude], resolved via
  /// reverse geocoding and cached across launches so it can show instantly
  /// next time instead of raw coordinates or a "Locating..." placeholder.
  String placeName = '';
  List<NearestBarberModel> barbers = const [];

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 0;
    longitude = prefs.getDouble('longitude') ?? 0;
    placeName = prefs.getString('placeName') ?? '';
    notifyListeners();

    await _refreshLocation(prefs);
    await _resolvePlaceName(prefs);
    await loadBarbers();
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
      barbers = await _repository.getNearestBarbers(
        latitude: latitude,
        longitude: longitude,
      );
      status = ViewStatus.success;
    } on AppException catch (e) {
      status = ViewStatus.error;
      errorMessage = e.message;
    }
    notifyListeners();
  }
}
