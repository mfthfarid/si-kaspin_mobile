import 'package:flutter/material.dart';
import 'package:kaspin/models/keranjang_model.dart';
import 'package:kaspin/transaksi/pembayaran.dart';

class Keranjang extends StatefulWidget {
  final List<CartModel> cartItems;
  Keranjang(this.cartItems);

  @override
  _KeranjangState createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  late int totalHarga;
  late String kodeProduk;
  late int jumlah;
  late int subtotal;

  @override
  void initState() {
    super.initState();
    updateTotalHarga();
    getProduk();
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

  void clearCart() {
    setState(() {
      widget.cartItems.clear();
      totalHarga = 0;
    });
  }

  void getProduk() {
    for (var cartItem in widget.cartItems) {
      setState(() {
        kodeProduk = cartItem.kodeProduk;
        jumlah = cartItem.jumlah;
        subtotal = cartItem.subtotal;
      });
    }
  }

  String formatRupiah(String nominal) {
    return 'Rp. ${nominal.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang"),
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
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            CartModel keranjang = widget.cartItems[index];
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
                    formatRupiah(totalHarga.toString()),
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
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 18)),
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
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Pembayaran(
                              totalHarga: totalHarga,
                              data: widget.cartItems,
                            )),
                  );

                  if (result == true) {
                    clearCart();
                  }
                },
                child: Text(
                  "Lanjutkan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
