import 'package:flutter/material.dart';
import 'package:kaspin/launch/constans.dart';
import 'package:kaspin/models/kategori_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<KategoriModel> kategorilist = [];

  @override
  void initState() {
    super.initState();
    fetchKategori();
  }

  @override
  void dispose() {
    super.dispose();
    kategorilist = [];
  }

  Future<List<KategoriModel>> fetchKategori() async {
    List<KategoriModel> usersList = [];
    var params = "";
    try {
      // var jsonResponse = await http.get(Palete.sUrl1 + params);
      var jsonResponse = await http.get(Uri.parse(Palete.sUrl1 + params));
      if (jsonResponse.statusCode == 200) {
        final jsonItems =
            json.decode(jsonResponse.body).cast<Map<String, dynamic>>();
        usersList = jsonItems.map<KategoriModel>((json) {
          return KategoriModel.fromJson(json);
        }).toList();

        setState(() {
          kategorilist = usersList;
        });
      }
    } catch (e) {
      usersList = kategorilist;
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Beranda"),
        ),
      ),
    );
  }
}
