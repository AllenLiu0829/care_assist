import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/models/product.dart';
import 'package:care_assist/view_models/product_page_vm.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        leading: const Icon(CupertinoIcons.circle_grid_hex_fill),
        title: Text(product.name),
        subtitle: Text(product.info),
        trailing: IconButton(
          onPressed: () {
            context.read<ProductViewModel>().deleteProduct(product);
            context.read<ProductViewModel>().updateViewModel([]);
          },
          icon: const Icon(Icons
              .playlist_remove), // const Icon(CupertinoIcons.cart_fill_badge_plus),
        ),
      ),
    );
  }
}
