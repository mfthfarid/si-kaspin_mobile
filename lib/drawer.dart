import 'package:flutter/material.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'package:kaspin/menu/retur.dart';
import 'package:kaspin/login/login.dart';
import 'package:kaspin/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _MyDrawer createState() => _MyDrawer();
}

class _MyDrawer extends State<MyDrawer> {
  int selectedIndex = 0;
  UserModel? loggedInUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel? user = await getUserData();
  }

  Future<UserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? idString = prefs.getString('id');
    final String? nama = prefs.getString('nama');
    final String? role = prefs.getString('role');

    // if (nama != null && role != null && idString != null) {
    //   int id = int.parse(idString);
    //   return UserModel(id: id, nama: nama, role: role);
    // }
    // return null;
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('nama');
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
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
                            FutureBuilder<String?>(
                              future: getUserName(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text(
                                    "Error",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  return Text(
                                    snapshot.data!,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "Nama tidak ditemukan",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  );
                                }
                              },
                            ),
                            FutureBuilder<String?>(
                              future: getUserRole(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text(
                                    "Error",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  return Text(
                                    snapshot.data!,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.amber,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "Nama tidak ditemukan",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  );
                                }
                              },
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
              selected: selectedIndex == 1,
              leading: Icon(
                Icons.money_rounded,
                color: selectedIndex == 1 ? Colors.green : Colors.white,
              ),
              title: Text(
                "Penjualan",
                style: TextStyle(
                    color: selectedIndex == 1
                        ? Colors.white
                        : Color.fromARGB(255, 56, 157, 66)),
              ),
              // textColor: Color.fromARGB(255, 56, 157, 66),
              onTap: () {
                // _onItemTapped(1);
                setState(() {
                  selectedIndex = 1;
                });
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Penjualan()),
                );
              },
            ),
            ListTile(
              selected: selectedIndex == 2,
              leading: Icon(
                Icons.restore_page_outlined,
                color: Colors.white,
              ),
              title: Text("Retur Penjualan"),
              textColor: Color.fromARGB(255, 56, 157, 66),
              onTap: () {
                // _onItemTapped(2);
                setState(() {
                  selectedIndex = 2;
                });

                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Retur()),
                );
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  selected: selectedIndex == 3,
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: Text("Log Out"),
                  textColor: Color.fromARGB(255, 56, 157, 66),
                  onTap: () {
                    // _onItemTapped(3);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
