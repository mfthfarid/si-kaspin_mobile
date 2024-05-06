import 'package:flutter/material.dart';
import 'package:kaspin/laciDrawer.dart';
import '';

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
        // leading: FlutterLogo(),
        // title: Text("Katalog"),
        // centerTitle: false,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       //
        //     },
        //     icon: Icon(Icons.more_vert),
        //   ),
        // ],
      ),
      drawer: MyDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 50,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://picsum.photos/id/${778 + index}/200/300",
                ),
              ),
            ),
            child: Text(
              "Hellow ${index + 1}",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
