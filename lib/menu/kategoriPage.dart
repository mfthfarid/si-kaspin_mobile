import 'package:flutter/material.dart';
import 'package:kaspin/transaksi/form_beli.dart';

class Kategori extends StatefulWidget {
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Kategori"),
        ),
      ),
    );
  }
}
