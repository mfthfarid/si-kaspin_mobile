import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/models/keranjang_model.dart';

class Keranjang extends StatelessWidget {
  final List<CartModel> cartItems;

  Keranjang(this.cartItems);

  String formatRupiah(String nominal) {
    return 'Rp. ${nominal.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    print('Cart Items:');
    for (var cartItem in cartItems) {
      print('Kode Produk: ${cartItem.kodeProduk}');
      print('Nama Produk: ${cartItem.namaProduk}');
      print('Jumlah: ${cartItem.jumlah}');
      print('Harga Satuan: ${formatRupiah(cartItem.hargaSatuan.toString())}');
      print('Subtotal: ${formatRupiah(cartItem.subtotal.toString())}');
      print('-------------------------');
    }
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Keranjang"),
      // ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Image.asset('data/tank-harimau.jpg'),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tank", style: TextStyle(fontSize: 16)),
                  Text("Jenis", style: TextStyle(fontSize: 10)),
                  SizedBox(width: 5),
                  Text("Stock", style: TextStyle(fontSize: 10)),
                  Text("Harga", style: TextStyle(fontSize: 14)),
                ],
              ),
              onTap: () {
                // Tambahkan logika untuk menangani aksi ketika item diklik
              },
            ),
          ],
        ),
      ),
    );
  }
}
