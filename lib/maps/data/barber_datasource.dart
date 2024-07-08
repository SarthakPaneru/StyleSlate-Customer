import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BarberDataSource {
  Future<LatLng> getBarberLocation() async {
    // Replace with actual logic to get the barber's location
    return LatLng(27.7680009, 85.472599); // Example coordinates
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];
      return "${place.locality}, ${place.country}";
    } catch (e) {
      throw Exception('Failed to get address');
    }
  }
}
