import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/models/pelanggan_model.dart';
import 'package:kaspin/services/PelangganAPI.dart';

class AddPelanggan extends StatefulWidget {
  const AddPelanggan({
    Key? key,
  }) : super(key: key);

  @override
  _AddPelanggan createState() => _AddPelanggan();
}

class _AddPelanggan extends State<AddPelanggan> {
  PelangganAPI2 pelangganAPI2 = PelangganAPI2();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController NoHPController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Pelanggan",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama',
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
                      controller: namaController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        hintText: "Masukan Nama Pelanggan",
                      ),
                      keyboardType: TextInputType.text,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   TextInputFormatter.withFunction((oldValue, newValue) {
                      //     String formattedText = (newValue.text);
                      //     return TextEditingValue(
                      //       text: formattedText,
                      //       selection: TextSelection.collapsed(
                      //           offset: formattedText.length),
                      //     );
                      //   }),
                      // ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                //
                Text(
                  'Alamat',
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
                      controller: alamatController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        hintText: "Masukan Alamat Pelanggan",
                      ),
                      keyboardType: TextInputType.text,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   TextInputFormatter.withFunction((oldValue, newValue) {
                      //     String formattedText = (newValue.text);
                      //     return TextEditingValue(
                      //       text: formattedText,
                      //       selection: TextSelection.collapsed(
                      //           offset: formattedText.length),
                      //     );
                      //   }),
                      // ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                //
                Text(
                  'No Handphone',
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
                      controller: NoHPController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        hintText: "Masukan No Handphone Pelanggan",
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          String formattedText = (newValue.text);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
