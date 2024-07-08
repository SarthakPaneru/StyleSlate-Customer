import 'package:google_maps_flutter/google_maps_flutter.dart';

class BarberEntity {
  final LatLng position;
  final String address;

  BarberEntity({
    required this.position,
    required this.address,
  });
}
