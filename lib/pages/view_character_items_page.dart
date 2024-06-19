import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/item_utils.dart';
import 'package:wow_stats_ds/models/extensions/character_utils.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/models/simulation/simulation_engine.dart';
import 'package:wow_stats_ds/pages/view_character_abilities_page.dart';
import 'package:wow_stats_ds/service/character_service.dart';
import 'package:wow_stats_ds/service/item_service.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';
import 'package:wow_stats_ds/widgets/build_stats_section_widget.dart';

class ViewCharacterItemsPage extends StatefulWidget {
  final Character character;

  const ViewCharacterItemsPage({super.key, required this.character});

  @override
  _ViewCharacterItemsPageState createState() => _ViewCharacterItemsPageState();
}

class _ViewCharacterItemsPageState extends State<ViewCharacterItemsPage> {
  final CharacterService _characterService = CharacterService();
  late Character _updatedCharacter;
  final _itemService = ItemService();

  @override
  void initState() {
    super.initState();
    _updatedCharacter = widget.character;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: siteBackgroundColor,
      body: ListView(
        children: [
          Text(
            'Character: ${_updatedCharacter.name}, Class: ${_updatedCharacter.classType.name}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                Expanded(
                  child: buildStatsSection(_updatedCharacter, context)
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AbilitiesPage(character: _updatedCharacter)),
                    );
                  },
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.asset('spellbook.png', fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
           ElevatedButton(
            onPressed: () async {
              double dps = await calculateDPS();
              print('DPS: $dps');
            },
            child: FutureBuilder<double>(
              future: calculateDPS(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('UR DPS: ${snapshot.data}');
                }
              },
            ),
          ),
          ...ItemType.values.map((itemType) => _buildEquipmentDropdown(itemType)),
          ElevatedButton(
            onPressed: _saveCharacter,
            child: const Text('Save Character'),
          ),
        ],
      ),
    );
  }

  Future<double> calculateDPS() {
    return SimulationEngine.runSimulation(_updatedCharacter);
  }

 Widget _buildEquipmentDropdown(ItemType itemType) {
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
        final text = currentItem == null 
          ? ' ${enumToString(itemType).capitalize()}: No item equipped' 
          : ' ${enumToString(itemType).capitalize()}: ${currentItem.name} equipped';

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
                        Text(text, style: charaTextStyle()),
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
            decoration: InputDecoration(
              labelStyle: charaTextStyle(),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: charaTileColor,
                  ),
          );
        }
      },
    );
  }

  Future<void> _saveCharacter() async {
    final docId = await _characterService.getDocumentIdByCharacterName(_updatedCharacter.name);
    if (docId != null) {
      await _characterService.updateCharacter(docId, _updatedCharacter);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Character saved!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Character not found!')));
    }
    Navigator.pop(context);  
  }
  
}
