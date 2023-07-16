import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> storeBearerToken(String token) async {
    await _storage.write(key: 'bearerToken', value: token);
  }

  Future<String?> retrieveBearerToken() async {
    return await _storage.read(key: 'bearerToken');
  }

}