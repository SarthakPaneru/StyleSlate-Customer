import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamro_barber_mobile/maps/data/barber_datasource.dart';
import 'package:hamro_barber_mobile/maps/domain/entities/barber_entity.dart';
import 'package:hamro_barber_mobile/maps/domain/entities/repositories/barber_repository.dart';

class BarberRepositoryImpl implements BarberRepository {
  final BarberDataSource dataSource;

  BarberRepositoryImpl(this.dataSource);

  @override
  Future<BarberEntity> getBarberLocation() async {
    final position = await dataSource.getBarberLocation();
    final address = await dataSource.getAddressFromLatLng(
        position.latitude, position.longitude);
    return BarberEntity(position: position, address: address);
  }
}
