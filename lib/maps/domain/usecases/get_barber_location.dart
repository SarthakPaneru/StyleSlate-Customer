import 'package:hamro_barber_mobile/maps/domain/entities/repositories/barber_repository.dart';

import '../entities/barber_entity.dart';

class GetBarberLocation {
  final BarberRepository repository;

  GetBarberLocation(this.repository);

  Future<BarberEntity> call() async {
    return await repository.getBarberLocation();
  }
}
