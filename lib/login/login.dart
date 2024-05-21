import 'package:flutter/material.dart';
import 'package:kaspin/menu/penjualan.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        if (username == 'admin' && password == 'admin123') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Penjualan()),
                          );
                        } else {
                          // Jika autentikasi gagal, tampilkan pesan kesalahan
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Username atau password salah.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
