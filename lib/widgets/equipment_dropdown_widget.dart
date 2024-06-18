import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/extensions/character_utils.dart';
import 'package:wow_stats_ds/models/extensions/item_utils.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/service/item_service.dart';

class EquipmentDropdown extends StatefulWidget {
  final ItemType itemType;
  final Character updatedCharacter;

   const EquipmentDropdown({
    super.key,
    required this.itemType,
    required this.updatedCharacter,
  });

  @override
  _EquipmentDropdownState createState() => _EquipmentDropdownState();
}

class _EquipmentDropdownState extends State<EquipmentDropdown> {
  late ItemType itemType;
  late Character _updatedCharacter;

  final _itemService = ItemService();

  @override
  void initState() {
    super.initState();
    itemType = widget.itemType;
    _updatedCharacter = widget.updatedCharacter;
  }
@override
Widget build(BuildContext context) {
  return StreamBuilder<List<Item>>(
    stream: _itemService.getItemsByType(itemType),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        final items = snapshot.data ?? [];
        final currentItem = getItemForSlot(itemType, _updatedCharacter);
        final text = currentItem == null ? ' ${enumToString(itemType).capitalize()}: No item equipped' : ' ${enumToString(itemType).capitalize()}: ${currentItem.name} equipped';

        return DropdownButtonFormField<Item>(
          value: currentItem,
          items: [
            DropdownMenuItem<Item>(
              value: currentItem,
              child: MouseRegion(
                child: Tooltip(
                  message: currentItem != null ? generateTooltipMessage(currentItem) : 'No item equipped',
                  child: Row(
                    children: [
                      if (currentItem != null)
                        Image.asset(
                          currentItem.imageUrl,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image);
                          },
                        ),
                        Text(text),
                    ],
                  ),
                ),
              ),
            ),
            ...items.map((item) => DropdownMenuItem<Item>(
                value: item,
                child: MouseRegion(
                  child: Tooltip(
                    message: generateTooltipMessage(item),
                    child: Row(
                      children: [
                        Image.asset(
                          item.imageUrl,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image);
                          },
                        ),
                        Text(item.name),
                      ],
                    ),
                  ),
                ),
              )),
            ],
            onChanged: (Item? value) {
              if (value != null) {
                setState(() {
                  updateCharacterEquipment(itemType, value, _updatedCharacter);
                });
              }
            },
          );
        }
      },
    );
  }
}