import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Customer {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> storeCustomerDetails(Map<String, dynamic> jsonResponse) async {

    final customerId = jsonResponse['id'];
    await _storage.write(key: 'customerId', value: customerId);

    Map<String, dynamic> user = jsonResponse['user'];
    Map<String, dynamic> jsonResponse1 = jsonDecode(jsonEncode(user));
    final customerEmail = jsonResponse1['email'];

    await _storage.write(key: 'customerEmail', value: customerEmail);

  }

  Future<String?> retrieveCustomerId() async {
    return await _storage.read(key: 'customerId');
  }

  Future<String?> retrieveCustomerEmail() async {
    return await _storage.read(key: 'customerEmail');
  }
}
