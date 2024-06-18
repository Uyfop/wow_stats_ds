import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/item.dart';

String generateStatsText(Character updatedCharacter) {
  final stats = updatedCharacter.getStats();
  return 
  '''
    Intellect: ${stats['intellect']}
    Stamina: ${stats['stamina']}
    Spirit: ${stats['spirit']}
    Critical Strike Chance amount: ${stats['criticalStrikeChance']} 
    Critical Strike Chance: ${(stats['criticalStrikeChance']! / 179.34).toStringAsFixed(2)}%
    Haste Rating: ${stats['hasteRating']}
    Hit Rating: ${stats['hitRating']}
    Mastery: ${stats['mastery']}
  ''';
}

Item? getItemForSlot(ItemType itemType, Character updatedCharacter) {
    final equipmentMap = {
      ItemType.head: updatedCharacter.head,
      ItemType.neck: updatedCharacter.neck,
      ItemType.shoulder: updatedCharacter.shoulder,
      ItemType.back: updatedCharacter.back,
      ItemType.chest: updatedCharacter.chest,
      ItemType.wrist: updatedCharacter.wrist,
      ItemType.hands: updatedCharacter.hands,
      ItemType.waist: updatedCharacter.waist,
      ItemType.legs: updatedCharacter.legs,
      ItemType.feet: updatedCharacter.feet,
      ItemType.finger1: updatedCharacter.finger1,
      ItemType.finger2: updatedCharacter.finger2,
      ItemType.trinket1: updatedCharacter.trinket1,
      ItemType.trinket2: updatedCharacter.trinket2,
      ItemType.mainHand: updatedCharacter.mainHand,
      ItemType.offHand: updatedCharacter.offHand,
      ItemType.ranged: updatedCharacter.ranged,
    };

    return equipmentMap[itemType];
}

void updateCharacterEquipment(ItemType itemType, Item item, Character updatedCharacter) {
    final equipmentMap = {
      ItemType.head: () => updatedCharacter.head = item,
      ItemType.neck: () => updatedCharacter.neck = item,
      ItemType.shoulder: () => updatedCharacter.shoulder = item,
      ItemType.back: () => updatedCharacter.back = item,
      ItemType.chest: () => updatedCharacter.chest = item,
      ItemType.wrist: () => updatedCharacter.wrist = item,
      ItemType.hands: () => updatedCharacter.hands = item,
      ItemType.waist: () => updatedCharacter.waist = item,
      ItemType.legs: () => updatedCharacter.legs = item,
      ItemType.feet: () => updatedCharacter.feet = item,
      ItemType.finger1: () => updatedCharacter.finger1 = item,
      ItemType.finger2: () => updatedCharacter.finger2 = item,
      ItemType.trinket1: () => updatedCharacter.trinket1 = item,
      ItemType.trinket2: () => updatedCharacter.trinket2 = item,
      ItemType.mainHand: () => updatedCharacter.mainHand = item,
      ItemType.offHand: () => updatedCharacter.offHand = item,
      ItemType.ranged: () => updatedCharacter.ranged = item,
    };

    final updateEquipment = equipmentMap[itemType];
    if (updateEquipment != null) {
      updateEquipment();
    }
}

