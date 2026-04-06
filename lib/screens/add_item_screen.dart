import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../models/item.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();

  final service = ItemService();

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        id: '',
        name: _nameController.text,
        quantity: int.parse(_quantityController.text.trim()),
        price: double.parse(_priceController.text.trim()),
        category: _categoryController.text.trim(),
        inStock: int.parse(_quantityController.text.trim()) > 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await service.addItem(item);

      Navigator.pop(context); // go back to list
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Item name is required';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Quantity is required';
                  }
                  final q = int.tryParse(value);
                  if (q == null) return 'Enter a valid number';
                  if (q < 0) return 'Cannot be negative';
                  return null;
                },
              ),

              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  final p = double.tryParse(value);
                  if (p == null) return 'Enter a valid number';
                  if (p < 0) return 'Cannot be negative';
                  return null;
                },
              ),

              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveItem,
                child: const Text('Save Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}