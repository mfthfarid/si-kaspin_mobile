import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/menu/penjualan.dart';

class formbeli extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            left: 16,
            right: 16.0,
            bottom: 16.0,
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
