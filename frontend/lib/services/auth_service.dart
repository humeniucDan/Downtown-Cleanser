//change ip on network change
import 'dart:convert';
import 'package:bitstone_contest/models/user_auth_model.dart';
import 'package:bitstone_contest/models/user_register_model.dart'
    show UserRegisterModel;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //change with current ip
  final String baseUrl = 'http://192.168.1.132:8080';

  Future<bool> login(UserAuthModel user) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final token = response.body;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      return true;
    } else {
      print('Login failed: ${response.body}');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }

  Future<bool> signup(UserRegisterModel user) async {
    final url = Uri.parse('$baseUrl/signup');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      //create an auto login after success
      print('Signup successful!');
      return true;
    } else {
      print('Signup failed: ${response.body}');
      return false;
    }
  }
}
