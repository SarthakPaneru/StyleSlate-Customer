import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/network/auth_interceptor.dart';
import 'package:hamro_barber_mobile/services/token_service.dart';

/// Central Dio instance, replacing the raw `http`-based `ApiService`
/// (`lib/config/api_service.dart`).
class DioClient {
  DioClient(TokenService tokenService) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: ApiConstants.timeoutSeconds),
        receiveTimeout: const Duration(seconds: ApiConstants.timeoutSeconds),
        headers: {'Content-Type': 'application/json'},
      ),
    )..interceptors.add(AuthInterceptor(tokenService));
  }

  late final Dio dio;
}
