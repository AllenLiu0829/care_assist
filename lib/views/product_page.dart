import 'package:care_assist/views/add_product_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/view_models/product_page_vm.dart';
import 'package:care_assist/views/product_tile.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<void> _openAddProductDialog(BuildContext context) async {
    final productViewModel = context.read<ProductViewModel>();
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const AddProductDialog(),
    );

    if (result != null) {
      productViewModel.createProduct(
          result['name'].toString(), result['info'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductViewModel>().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company\'s Products Informantion'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.cart_fill),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ProductTile(
          product: products[index],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () => _openAddProductDialog(context),
        icon: const Icon(CupertinoIcons.add_circled_solid),
      ),
    );
  }
}
