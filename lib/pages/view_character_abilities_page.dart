import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/service/ability_service.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';

class AbilitiesPage extends StatefulWidget {
  final Character character;

  const AbilitiesPage({super.key, required this.character});

  @override
  _AbilitiesPageState createState() => _AbilitiesPageState();
}

class _AbilitiesPageState extends State<AbilitiesPage> {
  final AbilityService _abilityService = AbilityService();
  late Future<List<Ability>> _abilitiesFuture;

  @override
  void initState() {
    super.initState();
    _abilitiesFuture = _fetchAbilities();
  }

  Future<List<Ability>> _fetchAbilities() async {
    return await _abilityService.getAbilitiesForClass(widget.character.classType.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: siteBackgroundColor,
      body: FutureBuilder<List<Ability>>(
        future: _abilitiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final abilities = snapshot.data ?? [];
           return ListView.builder(
              itemCount: abilities.length,
              itemBuilder: (context, index) {
                final ability = abilities[index];
                return ListTile(
                  leading: Image.asset(
                    "assets/ability_img/${ability.name}.jpg",
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                  title: Text(ability.name, style: charaTextStyle()),
                  subtitle: Text(ability.description, style: charaTextStyle()),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${ability.dps} DPS', style: charaTextStyle()),
                      Text('${ability.cooldown} Cooldown', style: charaTextStyle()),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
