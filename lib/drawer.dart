import 'package:flutter/material.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'package:kaspin/menu/retur.dart';
import 'package:kaspin/login/login.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawer createState() => _MyDrawer();
}

class _MyDrawer extends State<MyDrawer> {
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
              padding: EdgeInsets.all(20),
              color: Color.fromARGB(255, 36, 34, 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('data/profile.png'),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bintang Malindo",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              "Operator",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 11,
                                  color: Color(0xFFB8B8B8)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Spasi antara header dan menu
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
              leading: Icon(
                Icons.money_rounded,
                color: Colors.white,
              ),
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
              leading: Icon(
                Icons.restore_page_outlined,
                color: Colors.white,
              ),
              title: Text("Retur"),
              textColor: Color.fromARGB(255, 56, 157, 66),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  onTap: () {
                    _onItemTapped(3);
                    logout(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ),
                    // );
                  },
                  selected: selectedIndex == 2,
                  // titleAlignment: Alignment.bottomCenter,
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: Text("Log Out"),
                  textColor: Color.fromARGB(255, 56, 157, 66),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void logout(BuildContext context) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LoginPage()));
}
