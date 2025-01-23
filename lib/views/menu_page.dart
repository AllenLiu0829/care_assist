import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:care_assist/services/navigation.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    var navigationService = context.watch<NavigationService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Care Assist'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.cart_fill),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_rounded),
          ),
        ],
      ),
      body: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ActionChip(
            avatar: const Icon(Icons.apartment),
            label: const Text('Company Informantion'),
            onPressed: () => navigationService.goCompanyInfoPage(),
          ),
          ActionChip(
            avatar: const Icon(Icons.all_inbox),
            label: const Text('Product List'),
            onPressed: () => navigationService.goProductListPage(),
          ),
          ActionChip(
            avatar: const Icon(CupertinoIcons.doc_text_search),
            label: const Text('Health Survey'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
