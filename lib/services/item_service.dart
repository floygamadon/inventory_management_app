import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class ItemService {
  final CollectionReference itemsRef =
      FirebaseFirestore.instance.collection('items');

  // Create
  Future<void> addItem(Item item) async {
    await itemsRef.add(item.toMap());
  }

  // Read (Stream)
  Stream<List<Item>> streamItems() {
    return itemsRef.snapshots().map((snap) {
      return snap.docs.map((d) {
        return Item.fromMap(
          d.data() as Map<String, dynamic>,
          d.id,
        );
      }).toList();
    });
  }

  // Update
  Future<void> updateItem(Item item) async {
    await itemsRef.doc(item.id).update(item.toMap());
  }

  // Delete
  Future<void> deleteItem(String id) async {
    await itemsRef.doc(id).delete();
  }
}