import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/pages/auth_page_login.dart';
import 'package:wow_stats_ds/service/auth_service.dart';
import 'package:wow_stats_ds/service/character_service.dart';
import 'package:wow_stats_ds/service/item_service.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';
import 'package:wow_stats_ds/widgets/item_grid_widget.dart';

class LeaderBoardPageItem extends StatefulWidget {
  final Character character;
  
  const LeaderBoardPageItem({
    super.key,
    required this.character,
  });

  @override
  _LeaderBoardPageItemCheck createState() => _LeaderBoardPageItemCheck();
}

class _LeaderBoardPageItemCheck extends State<LeaderBoardPageItem> {
  final CharacterService _characterService = CharacterService();
  final ItemService _itemService = ItemService();
  final AuthService _authService = AuthService();

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
      body: Expanded(
        child: ItemGrid(
          itemStream: _characterService.getItemsByCharacterName(widget.character.name),
          itemService: _itemService,
          character: widget.character,
        ),
      ),
    );
  }
}
