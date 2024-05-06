import 'package:flutter/material.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'package:kaspin/menu/profile.dart';
import 'package:kaspin/menu/retur.dart';
import 'package:avatar_glow/avatar_glow.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawer createState() => _MyDrawer();
}

class _MyDrawer extends State {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 36, 34, 32),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Color.fromARGB(255, 36, 34, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset("data/LogoApp.png"),
                  // IconButton(
                  //   icon: Icon(Icons.menu),
                  //   color: Colors.white,
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                  // SizedBox(height: 30),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              // size: 9,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Bintang Malindo",
                            style: TextStyle(
                                fontFamily: "Poppins", color: Colors.white),
                          ),
                          Text(
                            "Kasir",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                color: Color.fromARGB(158, 255, 255, 255)),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Penjualan()),
                      );
                    },
                    selected: selectedIndex == 1,
                    leading: Icon(Icons.money_rounded),
                    title: Text("Penjualan"),
                    textColor: Color.fromARGB(255, 56, 157, 66),
                  ),
                  ListTile(
                    onTap: () {
                      _onItemTapped(2);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Retur()),
                      );
                    },
                    selected: selectedIndex == 2,
                    leading: Icon(Icons.restore_page_outlined),
                    title: Text("Retur"),
                    textColor: Color.fromARGB(255, 56, 157, 66),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
