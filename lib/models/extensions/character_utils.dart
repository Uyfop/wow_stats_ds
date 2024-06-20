import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/service/character_service.dart';

String generateStatsText(Character updatedCharacter) {
  final stats = updatedCharacter.getStats();
  double critChance = 0;
  String statsText = '';

  if(stats['intellect'] != 0) {
    statsText += 'Intellect: ${stats['intellect']}\n';
  }

  if(stats['strength'] != 0) {
    statsText += 'Strength: ${stats['strength']}\n';
  }

  if(stats['agility'] != 0) {
    statsText += 'Agility: ${stats['agility']}\n';
  }

  if(stats['stamina'] != 0) {
    statsText += 'Stamina: ${stats['stamina']}\n';
  }

  if(stats['spirit'] != 0) {
    statsText += 'Spirit: ${stats['spirit']}\n';
  }

  if(stats['criticalStrikeChance'] != 0){
    statsText += 'Critical Strike Rating: ${stats['criticalStrikeChance']}\n';
    critChance = stats['criticalStrikeChance']! / 179.34;
  }

  if(updatedCharacter.classType.name == 'mage' || updatedCharacter.classType.name == 'warlock' || updatedCharacter.classType.name == 'priest') {
    critChance += stats['intellect']!/648;
  }

  if (critChance != 0){
    statsText += 'Critical Strike Chance: ${critChance.toStringAsFixed(2)}%\n';
  }

  if (stats['expertiseRating'] != 0) {
    statsText += 'Expertise Rating: ${stats['expertiseRating']}\n';
  }

  // if(updatedCharacter.classType.name == 'Mage') {
  //   statsText += 'Spell Power: ${stats['spellPower']}\n';
  // }

  if(stats['hasteRating'] != 0) {
    statsText += 'Haste Rating: ${stats['hasteRating']}\n';
  }

  if(stats['hitRating'] != 0) {
    statsText += 'Hit Rating: ${stats['hitRating']}\n';
  }

  if(stats['mastery'] != 0) {
    statsText += 'Mastery: ${stats['mastery']}\n';
  }


  return statsText;
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

Future<void> deleteCharacterUtil(BuildContext context, String characterName, CharacterService characterService) async {
  bool confirmDelete = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Character'),
        content: Text('Are you sure you want to delete $characterName?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmDelete) {
    String? docId = await characterService.getDocumentIdByCharacterName(characterName);
    if (docId != null) {
      await characterService.deleteCharacter(docId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$characterName has been deleted.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Character not found.'),
        ),
      );
    }
  }
}


