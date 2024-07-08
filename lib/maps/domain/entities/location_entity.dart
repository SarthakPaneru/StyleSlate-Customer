import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationEntity {
  final LatLng position;
  final String address;

  LocationEntity({
    required this.position,
    required this.address,
  });
}
