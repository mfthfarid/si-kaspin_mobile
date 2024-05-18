import 'package:flutter/material.dart';
import 'package:kaspin/models/produk_model.dart';

class Item extends StatelessWidget {
  ProductModel product;

  Item({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          child: Image.asset(
            product.pathGambar,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF202224)),
            ),
            Text(
              '${product.kategori.name} | Stok : ${product.stok}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Rp. ${product.harga}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF389D42),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
