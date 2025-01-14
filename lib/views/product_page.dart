import 'package:flutter/material.dart';

import 'package:care_assist/views/product_tile.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView(
        children: const [
          ProductTile(),
          ProductTile(),
          ProductTile(),
        ],
      ),
    );
  }
}
