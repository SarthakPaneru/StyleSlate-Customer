import 'dart:convert';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  void processData(String responseData) {
    final data = json.decode(responseData);
    // Process the data...
    print('Processing...........');
    print(data);
  }

  Future<http.Response> get(String value) async {
    try {
      print('.......................');
      Uri uri = Uri.parse('${ApiConstants.baseUrl}$value');
      // params /*String|Iterable<String>*/
      print('URI: $uri');
      // final re = await http.head(uri, headers: ApiConstants.headers);
      ApiConstants apiConstants = ApiConstants();
      Map<String, String> headers = await apiConstants.getHeaders();
      final response = await http.get(uri, headers: headers);
      // print('Response with token: $re');
      print('Spring: ${response.statusCode}');

      print('HERE ');
      print(response.body);
      processData(response.body);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> post(String url, String body) async {
    try {
      Uri uri = Uri.parse('${ApiConstants.baseUrl}$url');
      Map<String, dynamic> bodyMap = json.decode(body);
      String bodyString = json.encode(bodyMap);

      http.Response response = await http.post(uri,
          headers: ApiConstants.postHeaders, body: bodyString);
      print('Main http: ${response.body}');
      return response;
    } catch (e) {
      print(e.toString());
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response = await http.put(uri,
          headers: ApiConstants.postHeaders, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> delete(String url) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);
      http.Response response =
          await http.delete(uri, headers: ApiConstants.postHeaders);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }
}
