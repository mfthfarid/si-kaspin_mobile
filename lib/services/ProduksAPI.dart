import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaspin/models/produk_model.dart';
import 'ApiConfig.dart';

class ProduksAPI {
  static const String endpoint = '/product';
  static const String endpoint1 = '/product/retur';

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

  static Future<Map<String, dynamic>?> postProduct(
    int id,
    String kodePelanggan,
    int total,
    int bayar,
    int kembalian,
    List data,
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
          'kodePelanggan': kodePelanggan,
          'total': total,
          'bayar': bayar,
          'kembalian': kembalian,
          'detailPenjualan': data
        }),
      );

      if (response.statusCode == 200) {
        print('Produk ditambahkan: ${response.body}');
        return jsonDecode(response.body);
      } else {
        return {'status': 'error', 'message': 'Server error: ${response.body}'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }

  static Future<Map<String, dynamic>?> postProductRetur(
    int id,
    String kodePelanggan,
    int total,
    int bayar,
    int kembalian,
    List data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.baseUrl + endpoint1),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'kodePelanggan': kodePelanggan,
          'total': total,
          'bayar': bayar,
          'kembalian': kembalian,
          'detailRetur': data
        }),
      );

      if (response.statusCode == 200) {
        print('Produk ditambahkan: ${response.body}');
        return jsonDecode(response.body);
      } else {
        return {'status': 'error', 'message': 'Server error: ${response.body}'};
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }
}
