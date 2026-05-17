import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_profile.dart';
import 'token_service.dart';

class ApiService {
static const String baseUrl =
    "https://ataadonationapi-d4c6bagtgydkdfc0.germanywestcentral-01.azurewebsites.net/api";
  static Future<UserProfile?> getProfile() async {
    final token = await TokenService.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/Users/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data);
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  }
}
