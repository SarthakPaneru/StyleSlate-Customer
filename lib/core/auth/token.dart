import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> storeBearerToken(String token) async {
    await storage.write(key: 'bearerToken', value: token);
  }

  Future<String?> retrieveBearerToken() async {
    return await storage.read(key: 'bearerToken');
  }

}