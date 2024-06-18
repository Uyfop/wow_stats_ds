import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/service/item_service.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';
import 'package:wow_stats_ds/widgets/item_dropdown_widget.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'intellect': TextEditingController(),
    'stamina': TextEditingController(),
    'spirit': TextEditingController(),
    'criticalStrikeChance': TextEditingController(),
    'hasteRating': TextEditingController(),
    'hitRating': TextEditingController(),
    'mastery': TextEditingController(),
  };

  final ItemService itemService = ItemService();

  ItemType _selectedItemType = ItemType.head;

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siteBackgroundColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ..._controllers.entries.map((entry) {
              return TextField(
                controller: entry.value,
                decoration: InputDecoration(
                  labelText: entry.key.capitalize(),
                  labelStyle: charaTextStyle()
                ),
                keyboardType: entry.key == 'name' ? TextInputType.text : TextInputType.number, style: charaTextStyle(),
              );
            }),
            const SizedBox(height: 16.0),
            ItemTypeDropdown(
              selectedItemType: _selectedItemType,
              onChanged: (ItemType? newValue) {
                setState(() {
                  _selectedItemType = newValue!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: charaButtonStyle(),
              onPressed: addItem,
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addItem() async {
    try {
      Item newItem = Item(
        name: _controllers['name']!.text,
        intellect: int.parse(_controllers['intellect']!.text),
        stamina: int.parse(_controllers['stamina']!.text),
        spirit: int.parse(_controllers['spirit']!.text),
        criticalStrikeChance: int.parse(_controllers['criticalStrikeChance']!.text),
        hasteRating: int.parse(_controllers['hasteRating']!.text),
        hitRating: int.parse(_controllers['hitRating']!.text),
        mastery: int.parse(_controllers['mastery']!.text),
        type: _selectedItemType.name, 
        imageUrl: 'assets/item_img/${_controllers['name']!.text}.jpg',
      );

      await itemService.addItem(newItem);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      _controllers.forEach((key, controller) => controller.clear());
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding item: $error'),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
