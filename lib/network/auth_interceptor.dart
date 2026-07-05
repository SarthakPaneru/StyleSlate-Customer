import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/services/token_service.dart';

/// Attaches the stored Bearer token to every request, replacing the manual
/// per-call header building in the old `ApiConstants.getHeaders()`/`postHeaders()`.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenService);

  final TokenService _tokenService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenService.retrieveBearerToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
