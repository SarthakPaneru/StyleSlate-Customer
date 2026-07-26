import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'interceptors/auth_interceptor.dart';

class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    final existing = _instance;
    if (existing != null) return existing;

    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: ApiConstants.timeoutSeconds),
        receiveTimeout: const Duration(seconds: ApiConstants.timeoutSeconds),
      ),
    );

    dio.interceptors.add(AuthInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    _instance = dio;
    return dio;
  }
}
