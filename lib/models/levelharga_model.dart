import 'package:flutter/material.dart';

class LevelHargaModel {
  final int id;
  final int idProduk;
  final String name;
  final int hargaSatuan;
  // final int hargaGrosir;
  LevelHargaModel({
    required this.id,
    required this.idProduk,
    required this.name,
    required this.hargaSatuan,
  });

  factory LevelHargaModel.fromJson(Map<String, dynamic> json) {
    return LevelHargaModel(
      id: json['id'] as int,
      idProduk: json['idProduk'] as int,
      name: json['name'] as String,
      hargaSatuan: json['harga'] as int,
      // hargaGrosir: json['hargaGrosir'] as int,
    );
  }
}
