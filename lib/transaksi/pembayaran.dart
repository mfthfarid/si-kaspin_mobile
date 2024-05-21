import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kaspin/services/ProduksAPI.dart';
import 'package:flutter/material.dart';

class Pembayaran extends StatefulWidget {
  final int totalHarga;
  Pembayaran({required this.totalHarga});

  @override
  _Pembayaran createState() => _Pembayaran();
}

class _Pembayaran extends State<Pembayaran> {
  ProduksAPI produksAPI = ProduksAPI();
  TextEditingController bayarController = TextEditingController();
  TextEditingController bayarController1 = TextEditingController();
  TextEditingController kembalianController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bayarController.addListener(() {
      _updateKembalian();
    });
  }

  @override
  void dispose() {
    bayarController.dispose();
    kembalianController.dispose();
    super.dispose();
  }

  String formatRupiah(int amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  void _updateKembalian() {
    if (bayarController.text.isNotEmpty && widget.totalHarga > 0) {
      String cleanText = bayarController.text.replaceAll(RegExp(r'[^\d]'), '');
      if (cleanText.isNotEmpty) {
        int bayar = int.parse(cleanText);
        int kembalian = bayar - widget.totalHarga;

        if (kembalian > 0) {
          kembalianController.text = formatRupiah(kembalian);
        } else {
          kembalianController.text = formatRupiah(0);
        }
      } else {
        kembalianController.text = formatRupiah(0);
      }
    } else {
      kembalianController.text = formatRupiah(0);
    }
  }

  String formatInput(String value) {
    String cleanText = value.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) return '';
    int amount = int.parse(cleanText);
    return formatRupiah(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembayaran"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bayar',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                height: 50.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: bayarController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      hintText: "Rp ",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        String formattedText = formatInput(newValue.text);
                        return TextEditingValue(
                          text: formattedText,
                          selection: TextSelection.collapsed(
                              offset: formattedText.length),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Kembalian',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                height: 50.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: kembalianController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                      hintText: "Rp ",
                    ),
                    keyboardType: TextInputType.number,
                    readOnly: true,
                  ),
                ),
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
                    formatRupiah(widget.totalHarga),
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
                    EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Color.fromARGB(255, 11, 49, 27);
                      }
                      return Colors.green;
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.black;
                      return Colors.white;
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return 100;
                      return 5;
                    },
                  ),
                ),
                onPressed: () {
                  int totalHarga = widget.totalHarga;
                  int bayar = int.parse(formatInput(bayarController.text)
                      .replaceAll(RegExp(r'[^\d]'), ''));
                  int kembalian = int.parse(
                      formatInput(kembalianController.text)
                          .replaceAll(RegExp(r'[^\d]'), ''));

                  if (bayar < totalHarga) {
                    // Menampilkan notifikasi jika jumlah yang dibayar kurang dari total harga
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Peringatan"),
                          content: Text(
                              "Jumlah yang dibayar kurang dari total harga."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Mengirimkan data ke API jika jumlah yang dibayar cukup
                    ProduksAPI.postProduct(widget.totalHarga, bayar, kembalian);
                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
