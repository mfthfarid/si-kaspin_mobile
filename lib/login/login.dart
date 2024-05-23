import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'package:kaspin/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:kaspin/services/ApiConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void fungsiLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      const endpoint = '/login';
      var response = await http.post(
        Uri.parse(ApiConfig.baseUrl + endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success') {
          UserModel user = UserModel.fromJson(jsonResponse['user']);
          print('Login berhasil: ${user.nama}');
          print('Data pengguna: ${jsonResponse['user']}');

          // Simpan data pengguna ke SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('id', user.id);
          await prefs.setString('username', user.username);
          await prefs.setString('nama', user.nama);
          await prefs.setString('role', user.role);
          // Simpan data lain yang diperlukan

          if (user.role == 'pegawai') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login berhasil')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Penjualan()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Username atau password salah')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Username atau password salah')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghubungi server')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  'data/kasir2.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                  height: 20.0), // Add space between the image and the text
              Text(
                "Selamat Datang",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0), // Add space between the texts
              Text(
                "Mari awali hari dengan Bismillah",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.0), // Add space before the form container
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Color.fromARGB(255, 11, 49, 27);
                            }
                            return Colors.green;
                          },
                        ),
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.black;
                            return Colors.white; // Warna default
                          },
                        ),
                      ),
                      onPressed: () {
                        fungsiLogin();
                        // if (username == 'admin' && password == 'admin123') {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Penjualan()),
                        //   );
                        // } else {
                        //   // Jika autentikasi gagal, tampilkan pesan kesalahan
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text('Username atau password salah.'),
                        //       backgroundColor: Colors.red,
                        //     ),
                        //   );
                        // }
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
