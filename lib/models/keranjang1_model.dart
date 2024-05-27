class CartModel1 {
  final String Kategori;
  final String kodeProduk;
  final String namaProduk;
  final int hargaSatuan;
  final String gambar;
  final int kode_operator;
  int jumlah;
  int subtotal;

  CartModel1({
    required this.Kategori,
    required this.namaProduk,
    required this.hargaSatuan,
    required this.kodeProduk,
    required this.jumlah,
    required this.subtotal,
    required this.gambar,
    required this.kode_operator,
  });
}
