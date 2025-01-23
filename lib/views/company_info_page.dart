import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/view_models/company_info_list_vm.dart';
import 'package:care_assist/views/company_info_tile.dart';
import 'package:care_assist/views/add_company_info_dialog.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  @override
  Widget build(BuildContext context) {
    final companyInfos = context.watch<CompanyInfoViewModel>().companyInfos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Informantion'),
      ),
      body: ListView.builder(
        itemCount: companyInfos.length,
        itemBuilder: (context, index) => CompanyInfoTile(
          companyInfo: companyInfos[index],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddCompanyInfoDialog(),
        ),
        icon: const Icon(CupertinoIcons.add_circled_solid),
      ),
    );
  }
}
