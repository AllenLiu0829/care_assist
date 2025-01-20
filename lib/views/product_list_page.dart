import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/views_models/product_list_page_vm.dart';
import 'package:care_assist/views/product_tile.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductListViewModel>().productList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => ProductTile(
          product: products[index],
        ),
      ),
    );
  }
}
