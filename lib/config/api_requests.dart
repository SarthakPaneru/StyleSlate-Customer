import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:hamro_barber_mobile/core/auth/login.dart';

import 'api_service.dart';
import 'package:http/http.dart' as http;

class ApiRequests {
  final ApiService _apiService = ApiService();

  // Get Email of currently logged in user
  Future<http.Response> getLoggedInUser() async {
    http.Response response = await _apiService
        .get('${ApiConstants.customersEndpoint}/get-logged-in-user');
    print('Logged in users stattus ${response.statusCode}');
    if (response.statusCode == 200) {
      // Successful login
      return response;
    } else {
      print('Login failed with status code: ${response.statusCode}');
      throw Future.error(
          'Login failed with status code: ${response.statusCode}');
    }
  }

  // Register the user
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

  // List all barbers
  Future<http.Response> getBarbers() async {
    http.Response response =
        await _apiService.get('${ApiConstants.barbersEndpoint}/get-all');
    return response;
  }

  

  // Get Current Customer
  Future<http.Response> getLoggedInCustomer() async {
    http.Response response =
        await _apiService.get('${ApiConstants.customersEndpoint}/get/');
    return response;
  }

  // Create Appointment
  Future<http.Response> createAppointment(
      int bookingStart, int bookingEnd, int barberId) async {
    final payload = {
      'bookingStart': bookingStart,
      'bookingEnd': bookingEnd,
      'barberId': barberId
    };
    final jsonPayload = jsonEncode(payload);
    http.Response response = await _apiService.post(
        '${ApiConstants.appointmentEndpoint}/save', jsonPayload);
    return response;
  }

  // upload user image
  Future<http.Response> uploadImage(File file) async {
    http.Response response = await _apiService.postImg('${ApiConstants.usersEndpoint}/image/save', file);
    return response;
  }
}
