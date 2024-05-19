class LevelHargaModel {
  String kode_level;
  String kode_produk;
  String nama_level;
  int harga_satuan;

  LevelHargaModel({
    required this.kode_level,
    required this.kode_produk,
    required this.nama_level,
    required this.harga_satuan,
  });

  factory LevelHargaModel.fromJson(Map<String, dynamic> json) {
    return LevelHargaModel(
      kode_level: json['kode_level'],
      kode_produk: json['kode_produk'],
      nama_level: json['nama_level'],
      harga_satuan: int.parse(json['harga_satuan']),
    );
  }
}
