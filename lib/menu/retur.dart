import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart'; // Pastikan impor ini benar, ganti 'kaspin' dengan package name yang sesuai

class Retur extends StatelessWidget {
  const Retur({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retur"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Batako Kotak",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Wembley, London',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.withOpacity(0.8)),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16, top: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '/per night',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
