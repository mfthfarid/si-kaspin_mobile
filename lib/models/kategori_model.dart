class KategoriModel {
  String kode_kategori;
  String nama_kategori;

  KategoriModel({
    required this.kode_kategori,
    required this.nama_kategori,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      kode_kategori: json['kode_kategori'],
      nama_kategori: json['nama_kategori'],
    );
  }
}
