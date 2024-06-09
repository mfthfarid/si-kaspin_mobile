import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/models/pelanggan_model.dart';

class AddPelanggan extends StatefulWidget {
  const AddPelanggan({
    Key? key,
  }) : super(key: key);

  @override
  _AddPelanggan createState() => _AddPelanggan();
}

class _AddPelanggan extends State<AddPelanggan> {
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
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('data1'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('data2'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('data3'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('data1'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('data2'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('data3'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
