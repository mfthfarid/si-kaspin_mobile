import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';

class Keranjang extends StatelessWidget {
  const Keranjang({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
