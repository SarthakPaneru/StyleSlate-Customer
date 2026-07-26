import 'package:hamro_barber_mobile/core/network/dio_client.dart';
import 'barber_api.dart';
import 'barber_repository.dart';
import 'barber_repository_impl.dart';

BarberRepository createBarberRepository() {
  return BarberRepositoryImpl(BarberApi(DioClient.instance));
}
