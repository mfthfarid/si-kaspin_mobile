import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaspin/models/user_model.dart';
import 'ApiConfig.dart';

class UserAPI {
  static const String endpoint = '/user';

  static Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(ApiConfig.baseUrl + endpoint),
        headers: {'ngrok-skip-browser-warning': 'true'});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<UserModel>((json) => UserModel.fromJson(json))
          .toList();
      // return jsonResponse.map((data) => UserModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
