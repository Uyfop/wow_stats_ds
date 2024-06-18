import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/service/item_service.dart';

class ItemAdder {
  final Map<String, TextEditingController> controllers;
  final ItemType selectedItemType;
  final ItemService itemService;
  final BuildContext context;

  ItemAdder({
    required this.controllers,
    required this.selectedItemType,
    required this.itemService,
    required this.context,
  });

  Future<void> addItem() async {
    try {
      Item newItem = Item(
        name: controllers['name']!.text,
        intellect: int.parse(controllers['intellect']!.text),
        stamina: int.parse(controllers['stamina']!.text),
        spirit: int.parse(controllers['spirit']!.text),
        criticalStrikeChance: int.parse(controllers['criticalStrikeChance']!.text),
        hasteRating: int.parse(controllers['hasteRating']!.text),
        hitRating: int.parse(controllers['hitRating']!.text),
        mastery: int.parse(controllers['mastery']!.text),
        type: selectedItemType.name, 
        imageUrl: 'assets/item_img/${controllers['name']!.text}.jpg',
        expertiseRating: int.parse(controllers['expertiseRating']!.text),
        strength: int.parse(controllers['strength']!.text),
        agility: int.parse(controllers['agility']!.text),
      );

      await itemService.addItem(newItem);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      controllers.forEach((key, controller) => controller.clear());
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding item: $error'),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}