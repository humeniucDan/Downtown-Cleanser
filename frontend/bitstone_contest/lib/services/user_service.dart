import 'dart:convert';
import 'package:bitstone_contest/models/user_details_model.dart';
import 'package:bitstone_contest/utils/variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final String baseUrlUtil = Utils.baseUrl;
  String get baseUrl => '$baseUrlUtil/users';
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<UserModel?> getCurrentUser() async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/id');
    print(url);

    final response = await http.get(
      url,
      headers: {
        'Cookie': 'jwToken=$token; Path=/;',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      print('Failed to load user: ${response.statusCode}');
      return null;
    }
  }

  Future<UserModel?> getCurrentUserWeb() async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/id');

    final response = await http.get(
      url,
      headers: {'credentials': 'include', 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      print('Failed to load user: ${response.statusCode}');
      return null;
    }
  }
}
