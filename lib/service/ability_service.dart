import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wow_stats_ds/models/ability.dart';

class AbilityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Ability>> getAbilitiesForClass(String classType) async {
    final querySnapshot = await _firestore.collection('abilities').where('classType', isEqualTo: classType).get();
    return querySnapshot.docs.map((doc) => Ability.fromJson(doc.data())).toList();
  }

  Future<void> addAbility(Ability ability) async {
    await _firestore.collection('abilities').add(ability.toJson());
  }

  Future<bool> checkAbilityExists(String abilityName) async {
    final querySnapshot = await _firestore.collection('abilities').where('name', isEqualTo: abilityName).get();
    return querySnapshot.docs.isNotEmpty;
  }
}
