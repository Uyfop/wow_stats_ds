  import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/extensions/character_utils.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';

Widget buildStatsSection(Character updatedCharacter, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stats:',
            style: charaTextStyle(), 
          ),
          const SizedBox(height: 8.0),
          Text(
            generateStatsText(updatedCharacter),
            style: charaTextStyle(),
          ),
        ],
      ),
    );
  }