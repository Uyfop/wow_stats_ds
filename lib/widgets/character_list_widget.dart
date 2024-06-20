import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/extensions/character_utils.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/pages/auth_page_login.dart';
import 'package:wow_stats_ds/pages/view_character_items_page.dart';
import 'package:wow_stats_ds/service/auth_service.dart';
import 'package:wow_stats_ds/service/character_service.dart';


class CharacterListWidget extends StatelessWidget {
  final CharacterService _characterService = CharacterService();
  final AuthService _authService = AuthService(); 

  CharacterListWidget({
    super.key,
    });
  

  @override
  Widget build(BuildContext context) {
    final currentUser = _authService.getCurrentUser();
    if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not authenticated. Please log in.'),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPageLogin()));
    }

    return Scaffold(
      backgroundColor: siteBackgroundColor,
      body: StreamBuilder<List<Character>>(
        stream: _characterService.getCharactersByUserId(currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final characters = snapshot.data!;
            return ListView.builder(
              
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  tileColor: homePageTileColor,
                  hoverColor: homePageHoverColor,
                  textColor: homePageTextColor,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), 
                    child: Text(character.name),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      deleteCharacterUtil(context, character.name, _characterService);
                    },
                  ),
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewCharacterItemsPage(character: character),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
