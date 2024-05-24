import 'package:flutter/material.dart';
import 'package:kaspin/menu/penjualan.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Mengambil informasi ukuran layar
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    // Menentukan ukuran padding dan margin berdasarkan ukuran layar
    var horizontalPadding = screenWidth * 0.05;
    var containerPadding = screenWidth * 0.05;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  // Container Gambar dan Teks
                  Expanded(
                    flex: 60,
                    // fit: FlexFit.tight,
                    child: Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'data/kasir2.jpg',
                            fit: BoxFit.contain,
                            width: screenWidth *
                                0.8, // Mengatur lebar gambar responsif
                            height: constraints.maxHeight *
                                0.3, // Tinggi gambar responsif
                          ),
                          SizedBox(
                            height: constraints.maxHeight *
                                0.02, // Ruang antara gambar dan teks
                          ),
                          Text(
                            "Selamat Datang",
                            style: TextStyle(
                              fontSize:
                                  screenWidth * 0.07, // Ukuran font responsif
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight *
                                0.01, // Ruang antara teks
                          ),
                          Text(
                            "Mari awali hari dengan Bismillah",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  screenWidth * 0.045, // Ukuran font responsif
                            ),
                          ),
                          // SizedBox(
                          //   height: constraints.maxHeight *
                          //       0.03, // Ruang sebelum container form
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // Container Form Login
                  Expanded(
                    flex: 40,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 220,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        margin:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                              decoration:
                                  InputDecoration(labelText: 'Username'),
                            ),
                            SizedBox(height: 5),
                            TextField(
                              controller: _passwordController,
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(50, 30)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
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

                                if (username == 'admin' &&
                                    password == 'admin123') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Penjualan()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Username atau password salah.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child:
                                  Text('Login', style: TextStyle(fontSize: 23)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // SizedBox(
                  //     height: constraints.maxHeight *
                  //         0.02), // Ruang antara form dan bawah layar
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
