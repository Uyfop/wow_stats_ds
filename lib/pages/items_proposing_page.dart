import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/item_utils.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/pages/auth_page_login.dart';
import 'package:wow_stats_ds/service/auth_service.dart';
import 'package:wow_stats_ds/service/character_service.dart';
import 'package:wow_stats_ds/service/item_service.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';
import 'package:wow_stats_ds/widgets/build_item_show_widget.dart';

class ItemsProposingPage extends StatefulWidget {
  const ItemsProposingPage({super.key});

  @override
  _ItemsProposingPageState createState() => _ItemsProposingPageState();
}

class _ItemsProposingPageState extends State<ItemsProposingPage> {
  final CharacterService _characterService = CharacterService();
  final ItemService _itemService = ItemService();
  final AuthService _authService = AuthService();
  Character? _selectedCharacter;
  late Stream<List<Item>> _selectedCharacterItems;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not authenticated. Please log in.'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthPageLogin()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siteBackgroundColor,
      appBar: const CustomAppBar(),
      body: StreamBuilder<List<Character>>(
        stream: _characterService.getCharactersByUserId(_authService.getCurrentUser()?.uid ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No characters found.'));
          } else {
            final characters = snapshot.data!;
            return Column(
              children: [
                Center(
                  child: DropdownButton<Character>(
                    hint: Text('Select a character', style: charaTextStyle()),
                    value: _selectedCharacter,
                    onChanged: (Character? newValue) {
                      setState(() {
                        _selectedCharacter = newValue;
                        _selectedCharacterItems = _characterService.getItemsByCharacterName(_selectedCharacter!.name);
                      });
                    },
                    style: charaTextStyle(),
                    dropdownColor: characterDropdown,
                    items: characters.map((Character character) {
                      return DropdownMenuItem<Character>(
                        value: character,
                        child: Text(character.name, style: charaTextStyle()),
                      );
                    }).toList(),
                  ),
                ),
                if (_selectedCharacter != null) ...[
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: StreamBuilder<List<Item>>(
                      stream: _selectedCharacterItems,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No items found.'));
                        } else {
                          final items = snapshot.data!;
                           return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 0, 
                                crossAxisSpacing: 5, 
                                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 5),
                              ),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                              return BuildItemWidget(
                                item: items[index],
                                index: index,
                                onTap: (item, index) {
                                  showItemDialog(context, item, index, _itemService, _selectedCharacter!);
                                },
                              );
                            },
                            );
                        }
                      },
                    ),
                  ),
                ]
              ],
            );
          }
        },
      ),
    );
  }
}