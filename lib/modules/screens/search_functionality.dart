// search_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  Future<List<Map<String, String>>> fetchBarbers(String query) async {
    final response = await http
        .get(Uri.parse('https://your-api-url.com/getBarbers?query=$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map<Map<String, String>>((item) {
        return {
          "name": item["name"] as String,
          "category": item["category"] as String,
        };
      }).toList();
    } else {
      throw Exception('Failed to load barbers');
    }
  }

  Future<List<String>> fetchFilters() async {
    // Simulated API call to fetch categories and services
    await Future.delayed(const Duration(seconds: 2));
    return ["Haircut", "Hair Style", "Beard", "Treatment", "Beauty Saloon"];
  }
}
