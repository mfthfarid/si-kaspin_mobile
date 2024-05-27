import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/models/keranjang_model.dart';
import 'package:kaspin/models/levelharga_model.dart';
import 'package:kaspin/services/ApiConfig.dart';
import 'package:kaspin/services/ProduksAPI.dart';
import 'package:kaspin/transaksi/keranjangPenjualan.dart';
import 'package:kaspin/models/produk_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Penjualan extends StatefulWidget {
  const Penjualan({
    Key? key,
  }) : super(key: key);

  @override
  _PenjualanState createState() => _PenjualanState();
}

class _PenjualanState extends State<Penjualan> {
  late Future<List<ProductModel>> futureProducts;

  TextEditingController jumlahController = TextEditingController();
  TextEditingController subtotalController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  LevelHargaModel? selectedLevelHarga;
  List<CartModel> keranjang = [];

  void updateSubtotal() {
    if (jumlahController.text.isNotEmpty && selectedLevelHarga != null) {
      int jumlah = int.parse(jumlahController.text);
      int harga = selectedLevelHarga!.harga_satuan;
      int subtotal = jumlah * harga;
      subtotalController.text = formatRupiah(subtotal);
    } else {
      subtotalController.clear();
    }
  }

  Future<void> createCartItem(
      ProductModel product, int jumlah, int harga, int subtotal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');

    if (id != null) {
      CartModel cartItem = CartModel(
        Kategori: product.kategori.nama_kategori,
        kodeProduk: product.kode_produk,
        namaProduk: product.nama_produk,
        jumlah: jumlah,
        hargaSatuan: harga,
        subtotal: subtotal,
        gambar: product.gambar,
        kode_operator: id, // Mengkonversi id ke String jika perlu
      );

      setState(() {
        keranjang.add(cartItem);
      });
    } else {
      print('No user ID found.');
      // Tangani kasus di mana id tidak ditemukan
    }
  }

  String formatRupiah(int amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(amount);
  }

  @override
  void initState() {
    super.initState();
    futureProducts = ProduksAPI.fetchProducts();
  }

  String getHargaByName(List<LevelHargaModel> harga, String name) {
    final levelHarga = harga.firstWhere((level) => level.nama_level == name,
        orElse: () => LevelHargaModel(
            kode_level: '', kode_produk: '', nama_level: '', harga_satuan: 0));
    return levelHarga.harga_satuan.toString();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Penjualan",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.green.shade300,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => keranjangPenjualan(keranjang)),
              );
            },
            tooltip: 'Keranjang',
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products found.'));
            } else {
              List<ProductModel> products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  ProductModel product = products[index];
                  return ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(ApiConfig.image + product.gambar),
                        ),
                      ),
                    ),
                    title: Text(product.nama_produk),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kategori: ${product.kategori.nama_kategori}'),
                        Text('Stock: ${product.stock.toString()}'),
                        Text(
                          // "Harga: ${formatRupiah(product.harga.first.harga_satuan)}",
                          "Harga: ${formatRupiah(product.harga.firstWhere(
                                (level) => level.nama_level == 'Ecer',
                                orElse: () => LevelHargaModel(
                                  kode_level: '',
                                  kode_produk: '',
                                  nama_level: '',
                                  harga_satuan: 0,
                                ),
                              ).harga_satuan)}",
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        selectedLevelHarga = null;
                        hargaController.clear();
                        jumlahController.clear();
                        subtotalController.clear();
                      });
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: [
                              Text("Pembelian"),
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
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Product Name',
                                    ),
                                    initialValue: product.nama_produk,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    enabled: false, // Non-editable field
                                  ),
                                  DropdownButtonFormField<LevelHargaModel>(
                                    decoration: InputDecoration(
                                        labelText: 'Pilih Level Harga'),
                                    value: selectedLevelHarga,
                                    items: [
                                      DropdownMenuItem<LevelHargaModel>(
                                        value: null,
                                        child: Text("Pilih harga"),
                                      ),
                                      ...product.harga.map((level) {
                                        return DropdownMenuItem<
                                            LevelHargaModel>(
                                          value: level,
                                          child: Text(level.nama_level),
                                        );
                                      }).toList(),
                                    ],
                                    onChanged: (LevelHargaModel? newValue) {
                                      setState(() {
                                        selectedLevelHarga = newValue;
                                        if (newValue != null) {
                                          hargaController.text = formatRupiah(
                                              newValue.harga_satuan);
                                          updateSubtotal();
                                        } else {
                                          hargaController.clear();
                                          subtotalController.clear();
                                        }
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    controller: hargaController,
                                    decoration: InputDecoration(
                                      labelText: 'Harga',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    enabled: false,
                                  ),
                                  TextFormField(
                                    controller: jumlahController,
                                    decoration: InputDecoration(
                                      labelText: 'Jumlah',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        updateSubtotal();
                                      });
                                    },
                                  ),
                                  TextField(
                                    controller: subtotalController,
                                    decoration: InputDecoration(
                                      labelText: 'Subtotal',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    enabled: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Color.fromARGB(255, 11, 49, 27);
                                  }
                                  return Colors.green;
                                }),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.all(16.0),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.black;
                                  return Colors.white;
                                }),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return 100;
                                  return 5;
                                }),
                              ),
                              onPressed: () async {
                                if (selectedLevelHarga != null &&
                                    jumlahController.text.isNotEmpty) {
                                  int jumlah = int.parse(jumlahController.text);
                                  int harga = int.parse(selectedLevelHarga!
                                      .harga_satuan
                                      .toString());
                                  int subtotal = jumlah * harga;

                                  int existingIndex = keranjang.indexWhere(
                                      (item) =>
                                          item.namaProduk ==
                                          product.nama_produk);

                                  if (existingIndex != -1) {
                                    setState(() {
                                      keranjang[existingIndex].jumlah += jumlah;
                                      keranjang[existingIndex].subtotal +=
                                          subtotal;
                                    });
                                  } else {
                                    await createCartItem(
                                        product, jumlah, harga, subtotal);
                                  }

                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Harap isi seluruh data')),
                                  );
                                }
                              },
                              child: Text(
                                'Tambah',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
