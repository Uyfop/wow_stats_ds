import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class CharacterService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AbilityService _abilityService = AbilityService();

  Future<void> addCharacter(Character character) async {
    await _firestore.collection('characters').add(character.toJson());
  }

  Stream<List<Character>> getCharacterByName(String name) {
    return _firestore.collection('characters').where('name', isEqualTo: name).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Character.fromJson(doc.data())).toList();
    });
  }

  Stream<List<Item>> getItemsByCharacterName(String name) {
    return _firestore
        .collection('characters')
        .where('name', isEqualTo: name)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return [];
      } else {
        final characterData = snapshot.docs.first.data();
        final List<Item> items = ItemType.values.map((itemType) {
          final itemJson = characterData[enumToString(itemType)];
          return itemJson != null ? Item.fromJson(itemJson) : Item.empty(itemType);
        }).toList();
        return items;
      }
    });
  }
   
  Future<List<Character>> getAllCharacters() async {
    QuerySnapshot snapshot = await _firestore.collection('characters').get();
    return snapshot.docs.map((doc) => Character.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }
 
  Future<String?> getDocumentIdByCharacterName(String name) async {
    final querySnapshot = await _firestore.collection('characters').where('name', isEqualTo: name).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
    return null;
  }

  Future<void> updateCharacter(String docId, Character character) async {
    await _firestore.collection('characters').doc(docId).update(character.toJson());
  }

  Future<List<Ability>> getAbilitiesForCharacterClass(String className) async {
    return _abilityService.getAbilitiesForClass(className);
  }

   Stream<List<Character>> getCharactersByUserId(String userId) {
    return _firestore.collection('characters').where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Character.fromJson(doc.data())).toList();
    });
  }

   Future<void> deleteCharacter(String docId) async {
    await _firestore.collection('characters').doc(docId).delete();
  }
}
