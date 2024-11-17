// api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'building.dart';

class ApiService {
  static List<dynamic> likedBuildingsData = [];

  static Future<List<dynamic>> fetchApiData(List<Building> likedBuildings) async {
    // Simulate an API call using liked buildings data
    // For demonstration, we're using a placeholder API
    try {
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5'));

      if (response.statusCode == 200) {
        likedBuildingsData = json.decode(response.body);

        // Store the liked buildings in the array
        for (var building in likedBuildings) {
          likedBuildingsData.add({
            'title': building.name,
            'body': building.description,
          });
        }

        return likedBuildingsData;
      } else {
        // Handle error
        return [];
      }
    } catch (e) {
      // Handle exception
      return [];
    }
  }
}
