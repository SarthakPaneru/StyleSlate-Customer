import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';

/// Attaches the stored bearer token to every request, if one exists.
/// Reuses the existing [Token] session store so it stays in sync with the
/// rest of the app (which is not being migrated in this pass).
class AuthInterceptor extends Interceptor {
  final Token _token = Token();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _token.retrieveBearerToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
