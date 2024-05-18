import 'package:kaspin/models/kategori_model.dart';
import 'package:kaspin/models/levelharga_model.dart';

class ProductModel {
  int id;
  String name;
  KategoriModel kategori;
  int stok;
  List<LevelHargaModel> harga;
  String pathGambar;

  ProductModel({
    required this.name,
    required this.kategori,
    required this.stok,
    required this.harga,
    required this.pathGambar,
    required this.id,
  });
}
