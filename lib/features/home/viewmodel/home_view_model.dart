import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hamro_barber_mobile/core/auth/customer.dart';
import 'package:hamro_barber_mobile/core/mvvm/view_status.dart';
import 'package:hamro_barber_mobile/core/network/api_exception.dart';
import 'package:hamro_barber_mobile/data/barbers/barber_repository.dart';
import 'package:hamro_barber_mobile/data/barbers/models/nearest_barber_model.dart';
import 'package:hamro_barber_mobile/data/profile/profile_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._repository, this._profileRepository);

  final BarberRepository _repository;
  final ProfileRepository _profileRepository;

  ViewStatus status = ViewStatus.loading;
  String? errorMessage;
  String firstName = '';
  double latitude = 0;
  double longitude = 0;

  /// Human-readable "City, Region" for [latitude]/[longitude], resolved via
  /// reverse geocoding. Empty until resolved, so the view can show a
  /// friendly placeholder instead of raw coordinates in the meantime.
  String placeName = '';
  List<NearestBarberModel> barbers = const [];

  Future<void> initialize() async {
    // Show the cached name immediately so the greeting isn't blank while
    // the live fetch below is in flight, then refresh it from the backend.
    firstName = await Customer().retrieveFirstName() ?? '';
    notifyListeners();
    unawaited(_refreshFirstName());

    final prefs = await SharedPreferences.getInstance();
    latitude = prefs.getDouble('latitude') ?? 0;
    longitude = prefs.getDouble('longitude') ?? 0;
    notifyListeners();

    await _refreshLocation(prefs);
    await _resolvePlaceName();
    await loadBarbers();
  }

  Future<void> _refreshFirstName() async {
    try {
      final account = await _profileRepository.getAccountDetails();
      firstName = account.firstName;
      notifyListeners();
    } on AppException {
      // Keep whatever was already loaded from the local cache above.
    }
  }

  Future<void> _refreshLocation(SharedPreferences prefs) async {
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
      // Fall back to the cached location already loaded above.
    }
  }

  Future<void> _resolvePlaceName() async {
    if (latitude == 0 && longitude == 0) return;

    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) return;

      final placemark = placemarks.first;
      final parts = [placemark.locality, placemark.administrativeArea]
          .where((part) => part != null && part.trim().isNotEmpty)
          .toList();
      placeName = parts.isNotEmpty
          ? parts.join(', ')
          : (placemark.country ?? '');
      notifyListeners();
    } catch (_) {
      // Leave placeName empty; the view falls back to a generic label
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
