import 'package:hamro_barber_mobile/maps/domain/entities/barber_entity.dart';

abstract class BarberRepository {
  Future<BarberEntity> getBarberLocation();
}
