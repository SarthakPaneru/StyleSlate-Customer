import 'package:hamro_barber_mobile/maps/domain/entities/repositories/location_repository.dart';

import '../entities/location_entity.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  Future<LocationEntity> call() async {
    return await repository.getCurrentLocation();
  }
}
