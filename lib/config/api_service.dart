import 'dart:convert';
import 'dart:io';
import 'package:hamro_barber_mobile/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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
      print('URI: $uri');
      // final re = await http.head(uri, headers: ApiConstants.headers);
      ApiConstants apiConstants = ApiConstants();
      Map<String, String> headers = await apiConstants.getHeaders();
      final response = await http.get(uri, headers: headers);
      // print('Response with token: $re');
      print('Spring: ${response.statusCode}');
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

      ApiConstants apiConstants = ApiConstants();
      Map<String, String> headers = await apiConstants.postHeaders();

      http.Response response =
          await http.post(uri, headers: headers, body: bodyString);
      print('Main http: ${response.body}');
      return response;
    } catch (e) {
      print(e.toString());
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> postImg(String url, File file) async {
    try {
      Uri uri = Uri.parse('${ApiConstants.baseUrl}$url');
      // Map<String, dynamic> bodyMap = json.decode(body);
      // String bodyString = json.encode(bodyMap);

      ApiConstants apiConstants = ApiConstants();
      Map<String, String> headers = await apiConstants.postImgHeaders();

      var request = http.MultipartRequest('PUT', uri);
      request.headers.addAll(headers);

      // Determine the MIME type of the file dynamically
      String? mimeType = lookupMimeType(file.path);
      if (mimeType == null) {
        print('Unable to determine MIME type of the file.');
        return http.Response("ERROR UPLOADING FILE", 400);
      }

      request.files.add(await http.MultipartFile.fromPath(
          'file', file.path, contentType: MediaType.parse(mimeType))); //, contentType: headers))
      request.send().then((response) {
        if (response.statusCode == 200) {
          print("Uploaded!");
          return response;
        }
      });
      //
      return http.Response("ERROR UPLOADING FILE", 500);
    } catch (e) {
      print(e.toString());
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);
      String bodyString = json.encode(body);

      ApiConstants apiConstants = ApiConstants();
      Map<String, String> headers = await apiConstants.postHeaders();

      http.Response response =
          await http.put(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }

  Future<http.Response> delete(String url) async {
    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + url);

      ApiConstants apiConstants = ApiConstants();
      Map<String, String> headers = await apiConstants.postHeaders();

      http.Response response = await http.delete(uri, headers: headers);
      return response;
    } catch (e) {
      return http.Response({"message": e}.toString(), 400);
    }
  }
}
