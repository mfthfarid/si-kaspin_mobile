import 'package:flutter/material.dart';
import 'package:kaspin/models/kategori_model.dart';
import 'package:kaspin/models/keranjang_model.dart';
import 'package:kaspin/models/produk_model.dart';
import 'package:kaspin/models/transaksi_model.dart';

class HomeProvider extends ChangeNotifier {
  String querySearch = '';
  int firstPage = 1;
  int currentPage = 1;
  late int lastPage;
  List<ProductModel> dataProduct = [];
  TransaksiModel transaksi = TransaksiModel(
    listProduct: [],
    totalHarga: 0,
  );

  void handleQty({required String option, required CartModel item}) {
    var index = transaksi.listProduct
        .indexWhere((element) => element.product.id == item.product.id);
    var temp = transaksi.listProduct.elementAt(index);

    // if (option == "tambah") {
    //   temp.qty += 1;
    //   temp.subtotal = temp.product.harga * temp.qty;
    // } else {
    //   if (temp.qty > 1) {
    //     temp.qty -= 1;
    //     temp.subtotal = temp.product.harga * temp.qty;
    //   }
    // }

    int harga = 0;

    for (var element in transaksi.listProduct) {
      harga += element.subtotal;
    }

    transaksi.totalHarga = harga;

    notifyListeners();
  }

  void addToCart(CartModel item, BuildContext context) {
    bool alreadyCart = false;

    for (var element in transaksi.listProduct) {
      if (element.product.id == item.product.id) {
        alreadyCart = true;
      }
    }

    // ignore: unnecessary_null_comparison
    if (!alreadyCart) {
      transaksi.listProduct.add(item);

      int harga = 0;
      for (var element in transaksi.listProduct) {
        harga += element.subtotal;
      }

      transaksi.totalHarga = harga;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Berhasil ditambahkan"),
        ),
      );
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data sudah ada di keranjang"),
        ),
      );
    }
  }

  // Future<void> fetchProduct() async {
  Future<List<ProductModel>> fetchProduct() async {
    List<ProductModel> temp = [];

    // temp.add(
    //   ProductModel(
    //     id: 1,
    //     name: "Batako Kotak Biasa",
    //     kategori: KategoriModel(
    //       id: 1,
    //       name: "Bata",
    //     ),
    //     stok: 20,
    //     harga: 2000,
    //     pathGambar: "https://picsum.photos/200/300",
    //   ),
    // );

    // temp.add(
    //   ProductModel(
    //     id: 2,
    //     name: "Tank Alutsista",
    //     kategori: KategoriModel(
    //       id: 2,
    //       name: "Alat Tempur",
    //     ),
    //     stok: 14,
    //     harga: 20000000,
    //     pathGambar: "https://picsum.photos/300/400",
    //   ),
    // );

    return temp;
    // dataProduct = temp;
    // notifyListeners();
  }

  void setQuerySearch({required String search}) {
    querySearch = search;
    notifyListeners();
  }
}
