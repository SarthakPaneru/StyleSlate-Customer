import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Replaces `core/auth/token.dart`. Secure-storage only: the old
/// `shared_preferences` mirror of the token was written but never read back
/// anywhere in the app, so it added no behavior.
class TokenService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const _bearerTokenKey = 'bearerToken';

  Future<void> storeBearerToken(String token) async {
    await _secureStorage.write(key: _bearerTokenKey, value: token);
  }

  Future<String?> retrieveBearerToken() async {
    return _secureStorage.read(key: _bearerTokenKey);
  }

  Future<void> clearBearerToken() async {
    await _secureStorage.delete(key: _bearerTokenKey);
  }
}
