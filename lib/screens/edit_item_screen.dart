import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';
import '../widgets/item_form.dart';

class EditItemScreen extends StatelessWidget {
  final Item item;

  const EditItemScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final service = ItemService();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ItemForm(
          item: item,
          buttonText: 'Update Item',
          onSubmit: (Item updatedItem) async {
            await service.updateItem(updatedItem);
          },
        ),
      ),
    );
  }
}