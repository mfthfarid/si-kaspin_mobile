import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'package:kaspin/menu/retur.dart';
import 'package:kaspin/models/keranjang1_model.dart';
import 'package:kaspin/models/pelanggan_model.dart';
import 'package:kaspin/services/PelangganAPI.dart';
import 'package:kaspin/services/ProduksAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PembayaranRetur extends StatefulWidget {
  final int totalHarga;
  final List<CartModel1> data;

  PembayaranRetur({
    required this.totalHarga,
    required this.data,
  });

  @override
  _PembayaranRetur createState() => _PembayaranRetur();
}

class _PembayaranRetur extends State<PembayaranRetur> {
  ProduksAPI produksAPI = ProduksAPI();
  PelangganAPI pelangganAPI = PelangganAPI();
  TextEditingController bayarController = TextEditingController();
  TextEditingController bayarController1 = TextEditingController();
  TextEditingController kembalianController = TextEditingController();
  List<PelangganModel> pelangganList = [];
  PelangganModel? selectedPelanggan;
  String? kodePelanggan;

  @override
  void initState() {
    super.initState();
    bayarController.addListener(() {
      _updateKembalian();
    });
    _fetchPelanggan();
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

  Future<void> _fetchPelanggan() async {
    try {
      PelangganAPI pelangganAPI = PelangganAPI();
      List<PelangganModel> pelanggan = await pelangganAPI.fetchPelanggan();
      setState(() {
        pelangganList = pelanggan;
      });
    } catch (e) {
      print('Failed to load pelanggan: $e');
    }
  }

  String formatInput(String value) {
    String cleanText = value.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) return '';
    int amount = int.parse(cleanText);
    return formatRupiah(amount);
  }

  @override
  void dispose() {
    bayarController.dispose();
    kembalianController.dispose();
    super.dispose();
  }

  Future<void> pushRetur(String kodePelanggan, List data) async {
    String cleanText =
        formatInput(bayarController.text).replaceAll(RegExp(r'[^\d]'), '');
    int bayar = int.parse(cleanText);
    int kembalian = int.parse(
        formatInput(kembalianController.text).replaceAll(RegExp(r'[^\d]'), ''));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');

    // ProduksAPI.postProduct(
    //     id!, kodePelanggan, widget.totalHarga, bayar, kembalian, data);

    try {
      final response = await ProduksAPI.postProductRetur(
          id!, kodePelanggan, widget.totalHarga, bayar, kembalian, data);

      if (response?["status"] == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Transaksi Berhasil"),
              content: Text("Data berhasil disimpan"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Retur(),
                        ),
                      );
                    },
                    child: Text('Close')),
              ],
            );
          },
        );
        setState(() {
          bayarController.text = 'Rp. 0';
          bayarController1.clear();
          kembalianController.clear();
          selectedPelanggan = null;
          kodePelanggan = '';
          widget.data.clear();
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Transaksi Gagal"),
              content: Text("Data gagal disimpan"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close')),
              ],
            );
          },
        );
        print('Failed to save data: $response');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Data gagal disimpan: $e"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close')),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengembalian",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Pelanggan',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: DropdownButtonFormField<PelangganModel>(
                    value: selectedPelanggan,
                    items: pelangganList.map((PelangganModel pelanggan) {
                      return DropdownMenuItem<PelangganModel>(
                        value: pelanggan,
                        child: Text(pelanggan.nama_pelanggan),
                      );
                    }).toList(),
                    onChanged: (PelangganModel? newValue) {
                      setState(() {
                        selectedPelanggan = newValue;
                        kodePelanggan = newValue?.kode_pelanggan;
                      });
                      print(kodePelanggan);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Pilih Pelanggan",
                    ),
                    isExpanded: true,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Bayar',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    height:
                        8.0), // Add some space between the label and the field
                Container(
                  width: double.infinity, // You can set a specific width here
                  height: 50.0, // Set the desired height
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
                        border: InputBorder.none, // Remove default border
                        isDense: true, // Reduces the height of the input
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0), // Adjust vertical padding
                        hintText: "Rp. ",
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
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Kembalian',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
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
                        hintText: "Rp. ",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Color.fromARGB(255, 194, 194, 194),
        child: Container(
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
                    formatRupiah(widget.totalHarga),
                    // '\$${_totalPrice.toStringAsFixed(2)}',
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
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Penjualan()),
                    // );
                    if (kodePelanggan != null) {
                      var data = widget.data.map((e) => {
                            'kodeProduk': e.kodeProduk,
                            'jumlah': e.jumlah,
                            'subtotal': e.subtotal
                          });
                      pushRetur(kodePelanggan!, data.toList());
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Peringatan"),
                            content:
                                Text("Harap pilih pelanggan terlebih dahulu."),
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
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.attach_money_rounded),
                      Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
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
