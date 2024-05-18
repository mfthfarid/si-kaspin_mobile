import 'package:flutter/material.dart';
import 'package:kaspin/drawer.dart';
import 'package:kaspin/menu/penjualan.dart';
import 'package:kaspin/models/produk_model.dart';

class formbeli extends StatelessWidget {
  final List<ProductModel> products;

  formbeli({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductModel product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Harga: ${product.harga.toString()}'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Pembelian'),
                  content: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Product Name'),
                          initialValue: product.name,
                          enabled: false, // Non-editable field
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Product Price'),
                          initialValue: product.harga.toString(),
                          enabled: false, // Non-editable field
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
