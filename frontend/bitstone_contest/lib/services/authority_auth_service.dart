import 'dart:convert';
import 'package:bitstone_contest/models/authority_model.dart';
import 'package:bitstone_contest/utils/variables.dart';
import 'package:http/http.dart' as http;

class AuthorityService {
  final String baseUrl = Utils.baseUrl;
  Future<bool> registerAuthority(AuthorityModel authority) async {
    final url = Uri.parse('$baseUrl/authority/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(authority.toJson(includePassword: true)),
      );
      print(jsonEncode(authority.toJson(includePassword: true)));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Failed to register authority: ${response.statusCode}');
        print('Body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error registering authority: $e');
      return false;
    }
  }
}
