import 'dart:convert';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:kaspin/components/item.dart';
import 'package:kaspin/components/produksi.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/launch/constans.dart';
import 'package:kaspin/menu/kategoriPage.dart';
import 'package:kaspin/models/levelharga_model.dart';
import 'package:kaspin/transaksi/form_beli.dart';
import 'package:kaspin/transaksi/keranjang.dart';
import 'package:http/http.dart';
import 'package:kaspin/models/kategori_model.dart';
import 'package:kaspin/models/keranjang_model.dart';
import 'package:kaspin/models/transaksi_model.dart';
import 'package:kaspin/models/produk_model.dart';
import 'package:kaspin/components/produksi.dart';
import 'package:kaspin/transaksi/pembayaran.dart';

class Keranjang extends StatefulWidget {
  const Keranjang({
    Key? key,
  }) : super(key: key);

  @override
  _Keranjang createState() => _Keranjang();
}

class _Keranjang extends State<Keranjang> {
  List<ProductModel> product = [];

  TextEditingController jumlahController = TextEditingController();
  TextEditingController subtotalController = TextEditingController();

  void updateSubtotal() {
    // final jumlah = int.tryParse(jumlahController.text) ?? 0;
    // final harga = ;
    // final subtotal = jumlah * harga;
    // subtotalController.text = 'Rp. $subtotal';
  }

  @override
  void initState() {
    super.initState();
    // final selectedHarga;
    // selectedHarga = product.hargaSatuan.first;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   product = null;
  // }

  // Future<List<Product>> fetchProduct() async* {
  //   List<Product> userList;
  //   var params = "/product";
  //   try {
  //     var jsonResponse = await http.get(Palete.sUrl1 + params);
  //     if (jsonResponse.statusCode == 200) {
  //       final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();
  //       userList = jsonItems.map<product>((json) {
  //         return product.fromJson(json);
  //       }).toList();

  //       setState(() {
  //         productlist = userList;
  //       });
  //     }
  //   } catch (e) {
  //     userList = productlist;
  //   }
  //   return userList;
  // }

  @override
  Widget build(BuildContext context) {
    // Data produk
    List<ProductModel> products = [
      ProductModel(
        id: 1,
        name: "Batako Kotak Biasa",
        kategori: KategoriModel(
          id: 1,
          name: "Bata",
        ),
        stok: 20000,
        harga: [
          LevelHargaModel(
            id: 1,
            idProduk: 1,
            name: "eceran",
            hargaSatuan: 3000,
          ),
          LevelHargaModel(
            id: 2,
            idProduk: 1,
            name: "grosir",
            hargaSatuan: 2000,
          ),
        ],
        pathGambar: "data/batako-kotak-biasa.jpg",
      ),
      ProductModel(
        id: 2,
        name: "Batako Ringan",
        kategori: KategoriModel(
          id: 1,
          name: "Bata",
        ),
        stok: 10000,
        harga: [
          LevelHargaModel(
            id: 1,
            idProduk: 2,
            name: "eceran",
            hargaSatuan: 2500,
          ),
          LevelHargaModel(
            id: 2,
            idProduk: 2,
            name: "grosir",
            hargaSatuan: 1500,
          ),
        ],
        pathGambar: "data/batako-ringan.jpg",
      ),
      ProductModel(
        id: 3,
        name: "Obeng",
        kategori: KategoriModel(
          id: 2,
          name: "Peralatan Mesin",
        ),
        stok: 15,
        harga: [
          LevelHargaModel(
            id: 1,
            idProduk: 3,
            name: "eceran",
            hargaSatuan: 5000,
          ),
          LevelHargaModel(
            id: 2,
            idProduk: 3,
            name: "grosir",
            hargaSatuan: 4000,
          ),
        ],
        pathGambar: "data/obeng.jpg",
      ),
      ProductModel(
        id: 4,
        name: "Tang",
        kategori: KategoriModel(
          id: 2,
          name: "Peralatan Mesin",
        ),
        stok: 15,
        harga: [
          LevelHargaModel(
            id: 1,
            idProduk: 4,
            name: "eceran",
            hargaSatuan: 10000,
          ),
          LevelHargaModel(
            id: 2,
            idProduk: 4,
            name: "grosir",
            hargaSatuan: 9000,
          ),
        ],
        pathGambar: "data/tang.jpg",
      ),
      // ProductModel(
      //   id: 5,
      //   name: "Tank Harimau",
      //   kategori: KategoriModel(
      //     id: 3,
      //     name: "Alat Tempur",
      //   ),
      //   stok: 3,
      //   harga: [
      //     LevelHargaModel(
      //       id: 1,
      //       idProduk: 5,
      //       name: "eceran",
      //       hargaSatuan: 1000000000,
      //     ),
      //     LevelHargaModel(
      //       id: 2,
      //       idProduk: 5,
      //       name: "grosir",
      //       hargaSatuan: 900000000,
      //     ),
      //   ],
      //   pathGambar: "data/tank-harimau.jpg",
      // ),
    ];

    String getHargaByName(List<LevelHargaModel> harga, String name) {
      final levelHarga = harga.firstWhere((level) => level.name == name,
          orElse: () =>
              LevelHargaModel(id: 0, idProduk: 0, name: '', hargaSatuan: 0));
      return levelHarga.hargaSatuan.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang"),
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
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            ProductModel product = products[index];
            return ListTile(
              leading: Container(
                width: 80, // Ukuran gambar lebih besar dari sebelumnya
                height: 80, // Ukuran gambar lebih besar dari sebelumnya
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius:
                      BorderRadius.circular(8), // Bisa diatur sesuai kebutuhan
                  image: DecorationImage(
                    fit: BoxFit
                        .cover, // Menggunakan BoxFit.cover agar gambar memenuhi kotak tanpa terpotong
                    image: AssetImage(product.pathGambar),
                  ),
                ),
              ),
              title: Text(product.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kategori: ${product.kategori.name}"),
                  Text("Stok: ${product.stok.toString()}"),
                  Text("Harga: RP. ${getHargaByName(product.harga, "eceran")}"),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        Text("Returan"),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    content: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Product Name'),
                            initialValue: product.name,
                            enabled: false,
                          ),
                          TextFormField(
                            controller: jumlahController,
                            decoration: InputDecoration(labelText: 'Jumlah'),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                updateSubtotal();
                              });
                            },
                          ),
                          DropdownButtonFormField<LevelHargaModel>(
                            decoration:
                                InputDecoration(labelText: 'Pilih Level Harga'),
                            value: product.harga.first,
                            items: product.harga.map((level) {
                              return DropdownMenuItem<LevelHargaModel>(
                                value: level,
                                child:
                                    Text(level.name), // Menampilkan hanya nama
                              );
                            }).toList(),
                            onChanged: (LevelHargaModel? newValue) {
                              setState(() {
                                product.harga = [newValue!];
                              });
                            },
                          ),
                          if (product.harga != null) ...[
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Harga'),
                              initialValue:
                                  'Rp. ${getHargaByName(product.harga, '')}',
                              enabled: false,
                            )
                          ],
                          TextField(
                            controller: subtotalController,
                            decoration: InputDecoration(labelText: 'Subtotal'),
                            // initialValue: 'Rp. ${product.harga}',
                            enabled: false,
                          ),
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'Alasan Retur'),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Simpan'),
                      ),
                    ],
                  ),
                );
              },
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pembayaran()),
                  );
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
