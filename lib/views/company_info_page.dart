import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/views_models/company_info_list_vm.dart';
import 'package:care_assist/views/company_info_tile.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<CompanyInfoPage> {
  @override
  Widget build(BuildContext context) {
    final companyInfos = context.watch<CompanyInfoViewModel>().companyInfos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Informantions'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.cart_fill),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: companyInfos.length,
        itemBuilder: (context, index) => CompanyInfoTile(
          companyInfo: companyInfos[index],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.add_circled_solid),
      ),
    );
  }
}
