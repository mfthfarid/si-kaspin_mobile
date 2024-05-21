import 'package:kaspin/models/kategori_model.dart';
import 'package:kaspin/models/levelharga_model.dart';

class ProductModel {
  String kode_produk;
  String nama_produk;
  int stock;
  String gambar;
  KategoriModel kategori;
  List<LevelHargaModel> harga;

  ProductModel({
    required this.kode_produk,
    required this.nama_produk,
    required this.stock,
    required this.gambar,
    required this.kategori,
    required this.harga,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      kode_produk: json['kode_produk'],
      nama_produk: json['nama_produk'],
      stock: json['stock'],
      gambar: json['gambar'],
      kategori: KategoriModel.fromJson(json['kategori']),
      harga: (json['level_harga'] as List)
          .map((e) => LevelHargaModel.fromJson(e))
          .toList(),
    );
  }
}
