import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../models/item.dart';
import '../screens/add_item_screen.dart';
import 'edit_item_screen.dart';

class ItemListScreen extends StatelessWidget {
  ItemListScreen({super.key});

  final service = ItemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory Items')),
      body: StreamBuilder<List<Item>>(
        stream: service.streamItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final items = snapshot.data ?? [];

          // Empty State
          if (items.isEmpty) {
            return const Center(child: Text('No items yet.'));
          }
          
          // List
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final item = items[i];

              return ListTile(
                title: Text(item.name),
                subtitle: Text('Qty: ${item.quantity}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.inStock ? Icons.check_circle : Icons.cancel,
                      color: item.inStock ? Colors.green : Colors.red,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        service.deleteItem(item.id);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditItemScreen(item: item),
                    ),
                  );
                },
                // delete example
                onLongPress: () {
                  service.deleteItem(item.id);
                 }, 
              );
            },
          );
        },
      ),
      // Button to add new items
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddItemScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}