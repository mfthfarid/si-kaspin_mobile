import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kaspin/login/login.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'constans.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPage createState() => _LaunchPage();
}

class _LaunchPage extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  @override
  void dispose() {
    super.dispose();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 2);
    return new Timer(duration, () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
        return new LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(255, 57, 58, 57),
              // offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Palete.bg1, Palete.bg2],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Image.asset(
                "data/LogoApp.png",
                height: 90.0,
                width: 90.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
