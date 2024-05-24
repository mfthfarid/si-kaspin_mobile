class UserModel {
  int id;
  String nama;
  String username;
  String password;
  String role;

  UserModel(
      {required this.id,
      required this.nama,
      required this.username,
      required this.password,
      required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nama: json['nama'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
    );
  }
}
