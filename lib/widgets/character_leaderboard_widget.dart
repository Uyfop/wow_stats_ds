import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/simulation/simulation_engine.dart';
import 'package:wow_stats_ds/service/character_service.dart';

class CharacterLeaderBoardWidget extends StatelessWidget {
  final CharacterService _characterService = CharacterService();

  CharacterLeaderBoardWidget({super.key});

  Future<double> _calculateDPS(Character character) async{
    return await SimulationEngine.runSimulation(character);
  }

  Future<List<Map<String, dynamic>>> _getSortedCharactersWithDPS() async {
    final characters = await _characterService.getAllCharacters();
    final List<Map<String, dynamic>> charactersWithDPS = [];
   // print('Fetched ${characters.length} characters');

    for (final character in characters) {
      final dps = await _calculateDPS(character);
   //   print('Character: ${character.name}, DPS: $dps');
      charactersWithDPS.add({
        'character': character,
        'dps': dps,
      });
    }

    charactersWithDPS.sort((a, b) => b['dps'].compareTo(a['dps']));
    return charactersWithDPS;
  }

    @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getSortedCharactersWithDPS(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No characters found'));
        } else {
          final charactersWithDPS = snapshot.data!;
          return ListView.builder(
            itemCount: charactersWithDPS.length,
            itemBuilder: (context, index) {
              final character = charactersWithDPS[index]['character'] as Character;
              final dps = charactersWithDPS[index]['dps'] as double;
              return ListTile(
                hoverColor: leaderBoardHoverColor,
                textColor: leaderBoardTextColor,
                title: Row(
                  children: [
                    Expanded(
                      child: Text((index + 1).toString()),
                    ),
                    Expanded(
                      child: Text(character.name),
                    ),
                    Expanded(
                      child: Text(dps.toStringAsFixed(0)),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}