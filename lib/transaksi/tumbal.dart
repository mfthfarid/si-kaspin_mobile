// import 'package:flutter/material.dart';
// import 'package:kaspin/menu/penjualan.dart';
// import 'package:kaspin/models/produk_model.dart';

// class FloatingFormDialog extends StatefulWidget {
//   final List<ProductModel> products;

//   FloatingFormDialog({required this.products});

//   @override
//   _FloatingFormDialogState createState() => _FloatingFormDialogState();
// }

// class _FloatingFormDialogState extends State<FloatingFormDialog> {
//   final _formKey = GlobalKey<FormState>();
//   String _name = '';
//   String _harga = '';

//   @override
//   void initState() {
//     super.initState();
//     _name = widget.products.name;
//     _harga = widget.products.harga as String;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Product Details'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Product Name'),
//               initialValue: _name,
//               enabled: false, // Non-editable field
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Product Email'),
//               initialValue: _harga,
//               enabled: false, // Non-editable field
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text('Close'),
//         ),
//       ],
//     );
//   }
// }
