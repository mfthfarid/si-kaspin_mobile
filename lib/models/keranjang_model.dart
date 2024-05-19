import 'package:kaspin/models/produk_model.dart';

class CartModel {
  final String Kategori;
  final String kodeProduk;
  final String namaProduk;
  final int hargaSatuan;
  final String gambar;
  int jumlah;
  int subtotal;

  CartModel({
    required this.Kategori,
    required this.namaProduk,
    required this.hargaSatuan,
    required this.kodeProduk,
    required this.jumlah,
    required this.subtotal,
    required this.gambar,
  });
}
