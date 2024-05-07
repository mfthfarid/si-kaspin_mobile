import 'package:flutter/material.dart';
import 'package:kaspin/laciDrawer.dart';
import './menu/profile.dart';
import './menu/penjualan.dart';
import './menu/retur.dart';
import 'package:kaspin/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("KasPin"),
          // leading: IconButton(
          //   icon: Image.asset("data/LogoApp.png"),
          //   onPressed: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          // ),
          ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          children: [
            Text("Content"),
            SizedBox(height: 20),
            Image.asset("data/LogoApp.png"),
          ],
        ),
      ),
    );
  }
}

// class _Penjualan extends StatelessWidget {
//   const _Penjualan({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Penjualan(),
//     );
//   }
// }

// class _Retur extends StatelessWidget {
//   const _Retur({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Retur(),
//     );
//   }
// }
