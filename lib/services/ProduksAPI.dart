import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaspin/models/produk_model.dart';
import 'ApiConfig.dart';

class ProduksAPI {
  static const String endpoint = '/product';

  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(ApiConfig.baseUrl + endpoint),
        headers: {'ngrok-skip-browser-warning': 'true'});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => ProductModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<void> postProduct(int total, int bayar, int kembalian) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl + endpoint),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode(<String, dynamic>{
          'total': total,
          'bayar': bayar,
          'kembalian': kembalian
        }),
      );

      if (response.statusCode == 200) {
        print("berhasil ditambahkan");
        print("Response: ${response.body}");
      } else {
        print("Failed to add product. Status code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
