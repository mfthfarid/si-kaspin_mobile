import 'package:kaspin/models/produk_model.dart';

class CartModel {
  final String namaProduk;
  final int hargaSatuan;
  final String kodeProduk;
  int jumlah;
  int subtotal;

  CartModel({
    required this.namaProduk,
    required this.hargaSatuan,
    required this.kodeProduk,
    required this.jumlah,
    required this.subtotal,
  });
}
