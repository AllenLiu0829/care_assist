import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      title: Text('a'),
    );
  }
}
