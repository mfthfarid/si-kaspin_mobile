import 'package:kaspin/models/keranjang_model.dart';

class Penjualan {
  final int total;
  final int bayar;
  final int kembalian;
  final List<CartModel> detailPenjualan;

  Penjualan(
      {required this.total,
      required this.bayar,
      required this.kembalian,
      required this.detailPenjualan});
}
