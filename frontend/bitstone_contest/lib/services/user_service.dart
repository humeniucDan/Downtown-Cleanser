import 'dart:convert';
import 'package:bitstone_contest/models/user_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String baseUrl = 'http://192.168.1.132:8080/users';
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<UserModel?> getCurrentUser() async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/id');

    final response = await http.get(
      url,
      headers: {'Cookie': 'jwToken=$token', 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      //handle not working
      print('Failed to load user: ${response.statusCode}');
      return null;
    }
  }
}
