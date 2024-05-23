class PelangganModel {
  String kode_pelanggan;
  String nama_pelanggan;
  String alamat;
  String no_hp;

  PelangganModel(
      {required this.kode_pelanggan,
      required this.nama_pelanggan,
      required this.alamat,
      required this.no_hp});

  factory PelangganModel.fromJson(Map<String, dynamic> json) {
    return PelangganModel(
      kode_pelanggan: json['kode_pelanggan'],
      nama_pelanggan: json['nama_pelanggan'],
      alamat: json['alamat'],
      no_hp: json['no_hp'],
    );
  }
}
