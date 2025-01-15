import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:care_assist/models/company_info.dart';

class CompanyInfoTile extends StatelessWidget {
  const CompanyInfoTile({super.key, required this.companyInfo});
  final CompanyInfo companyInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        leading: const Icon(CupertinoIcons.circle_grid_hex_fill),
        title: Text(companyInfo.name),
        subtitle: Text(companyInfo.info),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.cart_fill_badge_plus),
        ),
      ),
    );
  }
}
