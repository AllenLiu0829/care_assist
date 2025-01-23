import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/view_models/company_info_list_vm.dart';

class AddCompanyInfoDialog extends StatelessWidget {
  const AddCompanyInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController companyNameController = TextEditingController();
    TextEditingController companyInfoController = TextEditingController();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: companyNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company Name',
              ),
            ),
            TextField(
              controller: companyInfoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company Information',
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    context.read<CompanyInfoViewModel>().createCompanyInfo(
                        companyNameController.text, companyInfoController.text);
                    context.read<CompanyInfoViewModel>().updateViewModel();
                    context.pop();
                  },
                  child: const Text('Confirm'),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Exit'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
