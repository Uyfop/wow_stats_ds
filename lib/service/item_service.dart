
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/item.dart';

class ItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addItem(Item item) async {
    await _firestore.collection('items').add(item.toJson());
  }

  Stream<List<Item>> getItems() {
    return _firestore.collection('items').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList();
    });
  }

  Stream<Item?> getItemByName(String name) {
     return _firestore.collection('items').where('name', isEqualTo: name).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList().firstOrNull;
    });
  }

 Stream<List<Item>> getItemsByType(ItemType itemType) {
    return _firestore
        .collection('items')
        .where('type', isEqualTo: enumToString(itemType))
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList();
        });
  }
}
