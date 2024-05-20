import 'package:flutter/material.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'package:kaspin/models/produk_model.dart';
import 'package:kaspin/models/produk_model.dart';
import 'package:kaspin/models/keranjang_model.dart';
import 'package:kaspin/models/levelharga_model.dart';
import 'package:kaspin/models/transaksi_model.dart';

class Pembayaran extends StatefulWidget {
  @override
  _Pembayaran createState() => _Pembayaran();
}

class _Pembayaran extends State<Pembayaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembayaran"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            // color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
          tooltip: 'Kembali',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Bayar',
                  labelStyle: TextStyle(
                      // fontFamily:
                      ),
                  hintText: 'Rp. 0',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              // if bayar lebih = kembalian
              // else bayar kurang = duwekmu kurang
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      'Kurang ${LevelHargaModel}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Harga:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Harga",
                    // '\$${_totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  // minimumSize: MaterialStateProperty.all(
                  //     Size(200, 50)),
                  // textStyle: MaterialStateProperty.all(
                  //     TextStyle(fontSize: 20)), // Ukuran teks lebih besar
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 18)),

                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Color.fromARGB(255, 11, 49, 27);
                    }
                    return Colors.green;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.black;
                    return Colors.white;
                  }),
                  elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return 100;
                    return 5;
                  }),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Penjualan()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.attach_money_rounded),
                    Text(
                      "Simpan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
