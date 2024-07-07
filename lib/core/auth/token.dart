import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Store the token securely using flutter_secure_storage and shared_preferences
  Future<void> storeBearerToken(String token) async {
    await _secureStorage.write(key: 'bearerToken', value: token);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Token", token);
    print("Bearer Token Stored: $token");
  }

  // Retrieve the token securely using flutter_secure_storage
  Future<String?> retrieveBearerToken() async {
    final String? token = await _secureStorage.read(key: 'bearerToken');
    return token;
  }

  // Clear the token from storage
  Future<void> clearBearerToken() async {
    await _secureStorage.delete(key: 'bearerToken');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("Token");
    print("Bearer Token Cleared");
  }
}
