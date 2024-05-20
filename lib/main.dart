import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/launch/launcher.dart';
import 'package:kaspin/transaksi/pembayaran.dart';
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
      body: (LaunchPage()),
    );
  }
}
