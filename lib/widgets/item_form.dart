import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemForm extends StatefulWidget {
  final Item? item;
  final Future<void> Function(Item item) onSubmit;
  final String buttonText;

  const ItemForm({
    super.key,
    this.item,
    required this.onSubmit,
    required this.buttonText,
  });

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _priceController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _quantityController = TextEditingController(
      text: widget.item != null ? widget.item!.quantity.toString() : '',
    );
    _priceController = TextEditingController(
      text: widget.item != null ? widget.item!.price.toString() : '',
    );
    _categoryController = TextEditingController(
      text: widget.item?.category ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final quantity = int.parse(_quantityController.text.trim());
    final now = DateTime.now();

    final item = Item(
      id: widget.item?.id ?? '',
      name: _nameController.text.trim(),
      quantity: quantity,
      price: double.parse(_priceController.text.trim()),
      category: _categoryController.text.trim(),
      inStock: quantity > 0,
      createdAt: widget.item?.createdAt ?? now,
      updatedAt: now,
    );

    await widget.onSubmit(item);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
              if (value == null || value.trim().isEmpty) {
                return 'Quantity is required';
              }
              final q = int.tryParse(value.trim());
              if (q == null) return 'Enter a valid whole number';
              if (q < 0) return 'Quantity cannot be negative';
              return null;
            },
          ),
          TextFormField(
            controller: _priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Price is required';
              }
              final p = double.tryParse(value.trim());
              if (p == null) return 'Enter a valid number';
              if (p < 0) return 'Price cannot be negative';
              return null;
            },
          ),
          TextFormField(
            controller: _categoryController,
            decoration: const InputDecoration(labelText: 'Category'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Category is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            child: Text(widget.buttonText),
          ),
        ],
      ),
    );
  }
}