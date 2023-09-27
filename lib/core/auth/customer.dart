import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Customer {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> storeCustomerDetails(
      Map<String, dynamic> jsonResponseCustomer) async {
    try {
      final customerId = jsonResponseCustomer['id'];

      Map<String, dynamic> user = jsonResponseCustomer['user'];
      Map<String, dynamic> jsonResponseUser = jsonDecode(jsonEncode(user));
      final customerEmail = jsonResponseUser['email'];
      final userId = jsonResponseUser['id'];
      final firstName = jsonResponseUser['firstName'];
      final lastName = jsonResponseUser['lastName'];
      final phone = jsonResponseUser['phone'];

      await _storage.write(key: 'customerId', value: customerId.toString());
      await _storage.write(key: 'userId', value: userId.toString());
      await _storage.write(key: 'customerEmail', value: customerEmail.toString());
      await _storage.write(key: 'firstName', value: firstName.toString());
      await _storage.write(key: 'lastName', value: lastName.toString());
      await _storage.write(key: 'phone', value: phone.toString());
    } catch (e) {
      // Handle Error
      print('Error storing customer details: $e');
    }
  }

  Future<String?> retrieveCustomerId() async {
    try {
      final customerId = await _storage.read(key: 'customerId');
      // You can add additional validation here if needed.
      if (customerId != null) {
        return customerId;
      } else {
        // Handle the case where customerId is not found in storage.
        print('Customer Id not found in storage');
        return null;
      }
    } catch (e) {
      // Handle any exceptions that may occur during retrieval.
      print('Error retrieving customer ID: $e');
      return null;
    }
  }

  Future<String?> retrieveCustomerEmail() async {
    return await _storage.read(key: 'customerEmail');
  }

  Future<String?> retrieveFirstName() async {
    return await _storage.read(key: 'firstName');
  }

  Future<String?> retrieveLastName() async {
    return await _storage.read(key: 'lastName');
  }

  Future<String?> retrieveUserId() async {
    return await _storage.read(key: 'userId');
  }

  Future<String?> retrievePhone() async {
    return await _storage.read(key: 'phone');
  }
}
