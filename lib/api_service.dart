import 'package:http/http.dart' as http;
import 'dart:convert';
import 'building.dart';

class ApiService {
  static List<dynamic> likedBuildingsData = [];

  static Future<List<dynamic>> fetchApiData(List<Building> likedBuildings) async {
    const String url = "https://api.sambanova.ai/v1/chat/completions";
    const String bearerToken = "e6ad01d4-aeb0-48b9-9f4e-a0db34790bb6";

    try {
      // Define the request payload
      Map<String, dynamic> payload = {
        "stream": true,
        "model": "Meta-Llama-3.1-8B-Instruct",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a helpful assistant who rates buildings on their energy efficiency. You will look at the building and rate it on a scale 1-5 with 5 being the most efficient. You will also give a very concise sentence explaining why you gave this rating and how to improve the efficiency. Your response will only have 1 number which is the rating and only one sentence (maximum 30 words)."
          },
          {"role": "user", "content": "Trump Tower"}
        ],
      };

      // Make a POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $bearerToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        // Parse and handle the response
        final responseData = jsonDecode(response.body);
        print("Response: $responseData");
        return responseData;
      } else {
        // Handle non-200 status codes
        print("Error: ${response.statusCode}");
        print("Response: ${response.body}");
        return [];
      }
    } catch (e) {
      print("An error occurred: $e");
      return [];
    }
  }
}
