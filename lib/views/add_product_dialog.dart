import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddProductDialog extends StatelessWidget {
  const AddProductDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productInfoController = TextEditingController();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Name',
              ),
            ),
            TextField(
              controller: productInfoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Information',
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop({
                      'name': productNameController.text,
                      'info': productInfoController.text
                    });
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
