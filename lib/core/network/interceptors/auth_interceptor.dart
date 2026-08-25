import 'package:dio/dio.dart';
import 'package:hamro_barber_mobile/core/auth/token.dart';

/// Attaches the stored bearer token to every request, if one exists --
/// except the public, pre-authentication auth endpoints below.
///
/// If a token from a previous session is still on the device (e.g. the
/// user logs out then registers a new account, or opens Register while
/// still signed in), it used to get attached to these calls too. The
/// backend doesn't expect an Authorization header on them and errors
/// out, so they're sent with the request body only, same as a client
/// with no stored session would send them.
const _publicAuthPaths = {
  '/auth/register',
  '/auth/login',
  '/auth/forgot-password',
  '/auth/confirm-forgot-password',
};

/// Reuses the existing [Token] session store so it stays in sync with the
/// rest of the app (which is not being migrated in this pass).
class AuthInterceptor extends Interceptor {
  final Token _token = Token();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_publicAuthPaths.contains(options.path)) {
      handler.next(options);
      return;
    }

    final token = await _token.retrieveBearerToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
