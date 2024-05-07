import 'package:flutter/material.dart';
import 'package:kaspin/laciDrawer.dart';
import './profile.dart';
import './retur.dart';

class Penjualan extends StatelessWidget {
  const Penjualan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Penjualan"),
        actions: [
          IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.add_shopping_cart_outlined),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Cari...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // filterSearchResu
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  ListTile(
                    leading: Image.asset('data/batako-kotak-biasa.jpg'),
                    title: Text("Batako Kotak Biasa"),
                    subtitle: Text("Harga"),
                    onTap: () {
                      //
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Image.asset('data/profile.png'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Batako Bulat", style: TextStyle(fontSize: 16)),
                        Text("Jenis", style: TextStyle(fontSize: 10))
                        // jenis barang
                        ,
                        SizedBox(width: 5),
                        Text("Stock", style: TextStyle(fontSize: 10))
                        // Stock
                        ,
                        Text("Harga", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    onTap: () {
                      //
                    },
                  ),
                  ListTile(
                    leading: Image.asset('data/tang.jpg'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tang", style: TextStyle(fontSize: 16)),
                        Text("Jenis", style: TextStyle(fontSize: 10))
                        // jenis barang
                        ,
                        SizedBox(width: 5),
                        Text("Stock", style: TextStyle(fontSize: 10))
                        // Stock
                        ,
                        Text("Harga", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    onTap: () {
                      //
                    },
                  ),
                  ListTile(
                    leading: Image.asset('data/obeng.jpg'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Obeng", style: TextStyle(fontSize: 16)),
                        Text("Jenis", style: TextStyle(fontSize: 10))
                        // jenis barang
                        ,
                        SizedBox(width: 5),
                        Text("Stock", style: TextStyle(fontSize: 10))
                        // Stock
                        ,
                        Text("Harga", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    onTap: () {
                      //
                    },
                  ),
                  ListTile(
                    leading: Image.asset('data/tank-harimau.jpg'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tank Beneran", style: TextStyle(fontSize: 16)),
                        Text("Jenis", style: TextStyle(fontSize: 10))
                        // jenis barang
                        ,
                        SizedBox(width: 5),
                        Text("Stock", style: TextStyle(fontSize: 10))
                        // Stock
                        ,
                        Text("Harga", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    onTap: () {
                      //
                    },
                  ),
                  ListTile(
                    leading: Image.asset('data/LogoApp.png'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Batako Bulat", style: TextStyle(fontSize: 16)),
                        Text("Jenis", style: TextStyle(fontSize: 10))
                        // jenis barang
                        ,
                        SizedBox(width: 5),
                        Text("Stock", style: TextStyle(fontSize: 10))
                        // Stock
                        ,
                        Text("Harga", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    onTap: () {
                      //
                    },
                  ),
                  ListTile(
                    leading: Image.asset('data/LogoApp.png'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Batako Bulat", style: TextStyle(fontSize: 16)),
                        Text("Jenis", style: TextStyle(fontSize: 10))
                        // jenis barang
                        ,
                        SizedBox(width: 5),
                        Text("Stock", style: TextStyle(fontSize: 10))
                        // Stock
                        ,
                        Text("Harga", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    onTap: () {
                      //
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
