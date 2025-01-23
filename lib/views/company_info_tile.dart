import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/models/company_info.dart';
import 'package:care_assist/services/navigation.dart';
import 'package:care_assist/view_models/company_info_list_vm.dart';

class CompanyInfoTile extends StatelessWidget {
  const CompanyInfoTile({super.key, required this.companyInfo});
  final CompanyInfo companyInfo;

  @override
  Widget build(BuildContext context) {
    final navigationService = context.watch<NavigationService>();
    return GestureDetector(
      onTap: () => navigationService.goProductPage(companyInfo.id.toString()),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: const Icon(CupertinoIcons.circle_grid_hex_fill),
          title: Text(companyInfo.name),
          subtitle: Text(companyInfo.info),
          trailing: IconButton(
            onPressed: () {
              context
                  .read<CompanyInfoViewModel>()
                  .deleteCompanyInfo(companyInfo);
              context.read<CompanyInfoViewModel>().updateViewModel();
            },
            icon: const Icon(Icons.playlist_remove),
          ),
        ),
      ),
    );
  }
}
