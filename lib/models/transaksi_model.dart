import 'package:kaspin/models/keranjang_model.dart';

class TransaksiModel {
  int totalHarga;
  List<CartModel> listProduct;

  TransaksiModel({
    required this.listProduct,
    required this.totalHarga,
  });
}
