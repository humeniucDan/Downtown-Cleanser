import 'dart:convert';
import 'dart:io';
import 'package:bitstone_contest/utils/variables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gps_data.dart';

class UploadService {
  static Future<void> uploadImage(File imageFile, GpsData gpsData) async {
    final String baseUrl = Utils.baseUrl;
    final uri = Uri.parse('$baseUrl/image/send');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('No token found in shared preferences');
    }
    var request =
        http.MultipartRequest('POST', uri)
          ..headers['Cookie'] = 'jwToken=$token'
          ..fields['gpsData'] = jsonEncode(gpsData.toJson())
          ..files.add(
            await http.MultipartFile.fromPath('image', imageFile.path),
          );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }
}
