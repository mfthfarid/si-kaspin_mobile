import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaspin/models/pelanggan_model.dart';
import 'ApiConfig.dart';

class PelangganAPI {
  Future<List<PelangganModel>> fetchPelanggan() async {
    var url = Uri.parse(ApiConfig.baseUrl + "/pelanggan");
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
