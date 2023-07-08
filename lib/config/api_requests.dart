import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';

import 'api_service.dart';
import 'package:http/http.dart' as http;

class ApiRequests {
  final ApiService _apiService = ApiService();

  Future<String?> getLoggedInUser() async {
    http.Response response = await _apiService
        .get('${ApiConstants.customersEndpoint}/get-logged-in-user');

    if (response.statusCode == 200) {
      // Successful login
      return response.body;
    } else {
      print('Login failed with status code: ${response.statusCode}');
    }
    return null;
  }

  Future<http.Response> register(String email, String password,
      String confirmPassword, String firstName, String lastName) async {
    final payload = {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'firstName': firstName,
      'lastName': lastName
    };
    final jsonPayload = jsonEncode(payload);

    http.Response response = await _apiService.post(
        '${ApiConstants.authEndpoint}/register', jsonPayload);

    return response;

  }
}
