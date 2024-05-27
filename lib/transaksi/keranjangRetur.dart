import 'package:flutter/material.dart';
import 'package:kaspin/models/keranjang1_model.dart';
import 'package:kaspin/models/keranjang_model.dart';
import 'package:kaspin/transaksi/pembayaranRetur.dart';

class KeranjangRetur extends StatefulWidget {
  final List<CartModel1> cartItems;
  KeranjangRetur(this.cartItems);

  @override
  _KeranjangReturState createState() => _KeranjangReturState();
}

class _KeranjangReturState extends State<KeranjangRetur> {
  late int totalHarga;

  @override
  void initState() {
    super.initState();
    updateTotalHarga();
  }

  void updateTotalHarga() {
    int total = 0;
    for (var cartItem in widget.cartItems) {
      total += cartItem.subtotal;
    }
    setState(() {
      totalHarga = total;
    });
  }

  String formatRupiah(String nominal) {
    return 'Rp. ${nominal.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keranjang Retur",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          tooltip: 'Kembali',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            CartModel1 KeranjangRetur = widget.cartItems[index];
            return ListTile(
              leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              title: Text(
                widget.cartItems[index].namaProduk,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatRupiah(widget.cartItems[index].subtotal.toString()),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text("Jumlah: ${widget.cartItems[index].jumlah}"),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                tooltip: 'Hapus',
                onPressed: () {
                  setState(() {
                    widget.cartItems.removeAt(index);
                    updateTotalHarga();
                  });
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Color.fromARGB(255, 194, 194, 194),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Harga:',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    formatRupiah(totalHarga.toString()),
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * 0.4,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 28, vertical: 18)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.red;
                      }
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
                  onPressed: totalHarga > 0
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PembayaranRetur(
                                      totalHarga: totalHarga,
                                      data: widget.cartItems,
                                    )),
                          );
                        }
                      : null,
                  child: Text(
                    "Lanjutkan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
