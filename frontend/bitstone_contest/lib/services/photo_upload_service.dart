import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gps_data.dart';

class UploadService {
  static Future<void> uploadImage(File imageFile, GpsData gpsData) async {
    final uri = Uri.parse('http://192.168.1.132:8080/image/send');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('No token found in shared preferences');
    }
    var request =
        http.MultipartRequest('POST', uri)
<<<<<<< HEAD
          ..headers['Cookie'] = 'jwToken=$token'
=======
          ..headers['Authorization'] = 'Bearer $token'
>>>>>>> 2f5e11a7356b1f0617ab9c515c118aab27e3a88a
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
