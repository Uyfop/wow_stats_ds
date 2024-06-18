import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/models/simulation/simulation_engine.dart';
import 'package:wow_stats_ds/service/item_service.dart';

String generateTooltipMessage(Item item) {
  String tooltipMessage = '';

  if (item.intellect != 0) {
    tooltipMessage += 'Intellect: ${item.intellect}\n';
  }
  if (item.stamina != 0) {
    tooltipMessage += 'Stamina: ${item.stamina}\n';
  }
  if (item.spirit != 0) {
    tooltipMessage += 'Spirit: ${item.spirit}\n';
  }
  if (item.criticalStrikeChance != 0) {
    tooltipMessage += 'Critical Strike: ${item.criticalStrikeChance}\n';
  }
  if (item.hasteRating != 0) {
    tooltipMessage += 'Haste: ${item.hasteRating}\n';
  }
  if (item.hitRating != 0) {
    tooltipMessage += 'Hit: ${item.hitRating}\n';
  }
  if (item.mastery != 0) {
    tooltipMessage += 'Mastery: ${item.mastery}\n';
  }
  if (item.expertiseRating != 0) {
    tooltipMessage += 'Expertise: ${item.expertiseRating}\n';
  }
  if (item.strength != 0) {
    tooltipMessage += 'Strength: ${item.strength}\n';
  }
  if (item.agility != 0) {
    tooltipMessage += 'Agility: ${item.agility}\n';
  }
  
  tooltipMessage += 'Type: ${item.type}';

  return tooltipMessage;
}

Future<void> showItemDialog(BuildContext context, Item currentItem, int index, ItemService itemService, Character selectedCharacter) async {
  final ItemType currentItemType = currentItem.name.isEmpty 
      ? ItemType.values[index]
      : getItemTypeFromString(currentItem.type);

  final items = await itemService.getItemsByType(currentItemType).first;
  final dpsIncrease = SimulationEngine.calculateDPSIncrease(items, currentItem, selectedCharacter.classType);

  final sortedItems = items.where((item) => item.name != currentItem.name).toList()
    ..sort((a, b) => dpsIncrease[b.name]!.compareTo(dpsIncrease[a.name]!));

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: siteBackgroundColor,
        title: Row(
          children: [
            Image.network(
              currentItem.imageUrl.isEmpty ? 'assets/item_img/empty_slot.jpg' : currentItem.imageUrl,
              height: 48,
              width: 48,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/item_img/empty_slot.jpg',
                  height: 48,
                  width: 48,
                );
              },
            ),
            const SizedBox(width: 8),
            Text(
              currentItem.name.isEmpty ? 'Empty Slot' : currentItem.name,
              style: charaTextStyle(),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in sortedItems)
                  ListTile(
                    leading: Image.network(
                      item.imageUrl.isEmpty ? 'assets/item_img/empty_slot.jpg' : item.imageUrl,
                      height: 48,
                      width: 48,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/item_img/empty_slot.jpg',
                          height: 48,
                          width: 48,
                        );
                      },
                    ),
                    title: Text(item.name, style: charaTextStyle()),
                    subtitle: Text('DPS Increase: ${dpsIncrease[item.name]}', style: charaTextStyle()),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

