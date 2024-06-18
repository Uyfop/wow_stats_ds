import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';

class ItemTypeDropdown extends StatelessWidget {
  final ItemType selectedItemType;
  final ValueChanged<ItemType?> onChanged;

  const ItemTypeDropdown({
    super.key,
    required this.selectedItemType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ItemType>(
      dropdownColor: characterDropdown,
      value: selectedItemType,
      onChanged: onChanged,
      items: ItemType.values.map<DropdownMenuItem<ItemType>>((ItemType value) {
        return DropdownMenuItem<ItemType>(
          value: value,
          child: Text(value.name.capitalize(), style: charaTextStyle()),
        );
      }).toList(),
    );
  }
}


