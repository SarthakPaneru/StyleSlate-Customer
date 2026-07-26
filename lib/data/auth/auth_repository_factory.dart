import 'package:hamro_barber_mobile/core/network/dio_client.dart';
import 'auth_api.dart';
import 'auth_repository.dart';
import 'auth_repository_impl.dart';

AuthRepository createAuthRepository() {
  return AuthRepositoryImpl(AuthApi(DioClient.instance));
}
