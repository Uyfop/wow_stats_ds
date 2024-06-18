import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/class_enum.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';
import 'package:wow_stats_ds/pages/auth_page_login.dart';
import 'package:wow_stats_ds/service/auth_service.dart';
import 'package:wow_stats_ds/service/character_service.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';

class CreateCharacterPage extends StatefulWidget {
  const CreateCharacterPage({super.key});

  @override
  _CreateCharacterPageState createState() => _CreateCharacterPageState();
}

class _CreateCharacterPageState extends State<CreateCharacterPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final CharacterService _characterService = CharacterService();
  CharacterClass? _selectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siteBackgroundColor,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              style: charaTextStyle(),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Character Name',
                labelStyle: charaTextStyle(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<CharacterClass>(
              dropdownColor: characterDropdown,
              value: _selectedClass,
              decoration: InputDecoration(
                labelText: 'Character Class', 
                labelStyle: charaTextStyle()
              ),
              items: CharacterClass.values.map((CharacterClass characterClass) {
                return DropdownMenuItem<CharacterClass>(
                  value: characterClass,
                  child: Text(characterClass.name.capitalize(), style: charaTextStyle()),
                );
              }).toList(),
              onChanged: (CharacterClass? newValue) {
                setState(() {
                  _selectedClass = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: charaButtonStyle(),
              onPressed: () {
                _createCharacter();
              },
              child: const Text('Create Character'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createCharacter() async {
    final String name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a character name.'),
        ),
      );
      return;
    }
    if (_selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a character class.'),
        ),
      );
      return;
    }
  
    final existingCharacters = await _characterService.getCharacterByName(name).first;
    if (existingCharacters.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Character with name "$name" already exists. Please choose a different name.'),
        ),
      );
      return;
    }

    final currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not authenticated. Please log in.'),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => AuthPageLogin()));
      return;
    }

    final Character character = Character(
      name: name,
      userId: currentUser.uid,
      classType: _selectedClass!, 
    );

    await _characterService.addCharacter(character);

    Navigator.pop(context);
  }
}
