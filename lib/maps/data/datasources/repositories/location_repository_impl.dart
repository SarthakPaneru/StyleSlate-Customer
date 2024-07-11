import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamro_barber_mobile/maps/data/datasources/location_datasource.dart';
import 'package:hamro_barber_mobile/maps/domain/entities/location_entity.dart';
import 'package:hamro_barber_mobile/maps/domain/entities/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<LocationEntity> getCurrentLocation() async {
    final position = await dataSource.getCurrentPosition();
    final address = await dataSource.getAddressFromLatLng(
        position.latitude, position.longitude);
    return LocationEntity(
      position: LatLng(position.latitude, position.longitude),
      address: address,
    );
  }
}
