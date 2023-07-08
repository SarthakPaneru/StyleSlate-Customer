import 'package:hamro_barber_mobile/core/auth/token.dart';

class ApiConstants {
  static const int maxRetryCount = 3;
  static const int timeoutSeconds = 30;
  static const String baseUrl = 'http://192.168.31.100:8080';

  // Auth's Endpoint
  static const String authEndpoint = '/auth';

  // User's Endpoint
  static const String usersEndpoint = '/user';

  // Customer's Endpoint
  static const String customersEndpoint = '/customer';

  // Barber's Endpoint
  static const String barbersEndpoint = '/barber';

  // Service's Endpoint
  static const String serviceEndpoint = '/service';

  // Appointment's Endpoint
  static const String appointmentEndpoint = '/appointment';

  // static const String bearerToken = Token().retrieveBearerToken().toString();

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${Token().retrieveBearerToken().toString()}',
  };

  static const Map<String, String> postHeaders = {
    'content-type': 'application/json',
    'accept': 'application/json',
  };
}
