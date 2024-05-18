import 'package:kaspin/models/produk_model.dart';

class CartModel {
  ProductModel product;
  int qty;
  int subtotal;

  CartModel({
    required this.product,
    required this.qty,
    required this.subtotal,
  });
}
