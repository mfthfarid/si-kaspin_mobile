import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaspin/models/pelanggan_model.dart';
import 'ApiConfig.dart';

class PelangganAPI {
  Future<List<PelangganModel>> fetchPelanggan() async {
    var url = Uri.parse(ApiConfig.baseUrl + "/pelanggan2");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<PelangganModel> pelanggan =
          data.map((data) => PelangganModel.fromJson(data)).toList();
      return pelanggan;
    } else {
      throw Exception("Failed to load data");
    }
  }
}

class PelangganAPI2 {
  static const String endpoint = '/pelanggan';

  static Future<List<PelangganModel>> fetchPelanggan() async {
    final response = await http.get(
      Uri.parse(ApiConfig.baseUrl + endpoint),
      headers: {'ngrok-skip-browser-warning': 'true'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PelangganModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>?> postPelanggan(
    int id,
    String nama,
    String alamat,
    String telepon,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl + endpoint),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'nama': nama,
          'alamat': alamat,
          'telepon': telepon,
        }),
      );

      if (response.statusCode == 200) {
        print('Pelanggan ditambahkan: ${response.body}');
        return jsonDecode(response.body);
      } else {
        return {'status': 'error', 'message': 'Server error: ${response.body}'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }
}
