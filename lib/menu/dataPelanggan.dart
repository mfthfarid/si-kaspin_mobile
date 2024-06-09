import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/models/pelanggan_model.dart';
import 'package:kaspin/services/PelangganAPI.dart';

class DataPelanggan extends StatefulWidget {
  const DataPelanggan({
    Key? key,
  }) : super(key: key);

  @override
  _DataPelanggan createState() => _DataPelanggan();
}

class _DataPelanggan extends State<DataPelanggan> {
  late Future<List<PelangganModel>> futurePelanggan;

  @override
  void initState() {
    super.initState();
    futurePelanggan = PelangganAPI2.fetchPelanggan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Pelanggan",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: FutureBuilder<List<PelangganModel>>(
          future: futurePelanggan,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products found.'));
            } else {
              List<PelangganModel> pelanggan = snapshot.data!;
              return ListView.builder(
                itemCount: pelanggan.length,
                itemBuilder: (context, index) {
                  PelangganModel pelanggan1 = pelanggan[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Warna latar belakang
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        // backgroundColor: Colors.blue,
                        child: Text(
                          // Teks nomor urut
                          (index + 1).toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      title: Text(pelanggan1.nama_pelanggan),
                      trailing: IconButton(
                        icon: Icon(Icons.info_outline_rounded),
                        color: Colors.amber,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Row(
                                children: [
                                  Text("Detail "),
                                  Text(pelanggan1.nama_pelanggan),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    color: Colors.red,
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
                                          labelText: 'Kode Pelanggan',
                                        ),
                                        initialValue: pelanggan1.kode_pelanggan,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        enabled: false,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Alamat',
                                        ),
                                        initialValue: pelanggan1.alamat,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        enabled: false,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'No Handphone',
                                        ),
                                        initialValue: pelanggan1.no_hp,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        enabled: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
