import 'package:hamro_barber_mobile/core/auth/token.dart';

class ApiConstants {
  static const int maxRetryCount = 3;
  static const int timeoutSeconds = 30;
  static const String baseUrl = 'http://192.168.1.101:8080';

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
  final Token _token = Token();

  // static const String bearerToken = Token().retrieveBearerToken().toString();

  Future<Map<String, String>> getHeaders() async {
    String? token = await _token.retrieveBearerToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }

  // static const Map<String, String> postHeaders = {
  //   'content-type': 'application/json',
  //   'accept': 'application/json',
  // };

  Future<Map<String, String>> postHeaders() async {
    String? token = await _token.retrieveBearerToken();
    Map<String, String> postHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return postHeaders;
  }

  Future<Map<String, String>> postImgHeaders() async {
    String? token = await _token.retrieveBearerToken();
    Map<String, String> postImgHeaders = {
      'content-type': 'multipart/form-data',
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return postImgHeaders;
  }
}
