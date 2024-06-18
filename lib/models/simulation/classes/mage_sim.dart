import 'dart:math';

import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/models/simulation/simulation.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class MageSimulationData extends SimulationData {
  final AbilityService _abilityService = AbilityService();

  @override
  Future<List<Ability>> getAbilities() async {
    return _abilityService.getAbilitiesForClass('Mage');
  }

  @override
  Future<double> runSimulation(Character character) async {
    final abilities = await getAbilities();
    Map<String, int> stats = character.getStats();
    double simulationDuration = 60;
    double totalDPS = 0;
    double critPercentage = 0;
    if (stats['intellect'] != null && stats['intellect'] != 0) {
      critPercentage += stats['intellect']!/648.91;
    } 
    if (stats['critRating'] != null && stats['critRating'] != 0) {
      critPercentage += stats['critRating']!/179.28;
    }

    Random random = Random();
    int consecutiveCrits = 0;
    Ability fireBall = abilities.firstWhere((a) => a.name == 'Fireball');
    Ability pyroBlast = abilities.firstWhere((a) => a.name == 'Pyroblast');
    int dps = 0;
    bool isCrit = false;
    double gcd = 1.5;
    int amountOfCrits = 0;

    while (simulationDuration > 0) {
      bool abilityExecuted = false; 
      if (fireBall.cooldown <= simulationDuration) {
        isCrit = random.nextDouble() < critPercentage;
        dps = fireBall.dps;
        if (isCrit) {
          consecutiveCrits++;
          dps *= 2;
          amountOfCrits++;
        } else {
          consecutiveCrits = 0;
        }
        if (consecutiveCrits > 1){
          dps += pyroBlast.dps;
        }
       // await Future.delayed(Duration(milliseconds: (abilities.firstWhere((a) => a.name == 'Fireball').castTime * 1000).toInt()));
        totalDPS += dps;
        simulationDuration -= fireBall.cooldown + gcd;
        abilityExecuted = true;
      }
      if (!abilityExecuted) {
        break;
      }
    }
    print(amountOfCrits == 0 ? 'No crits' : 'Amount of crits: $amountOfCrits');
    print('Running mage simulation');
    print('Total DPS: $totalDPS');

    return totalDPS;
  }

  @override
  Map<String, int> get defaultStatWeights => {
    'intellect': 3,
    'stamina': 0,
    'spirit': 0,
    'strength': 0,
    'hasteRating': 1,
    'hitRating': 1,
    'mastery': 0,
    'critRating': 2,
    'agility': 0,
    'expertiseRating': 0,
  };

  @override
  Map<String, int> calculateDPSIncrease(List<Item> items, Item currentItem) {
    final Map<String, int> defaultWeights = defaultStatWeights;
    final int currentStats = calculateTotalStats(currentItem, defaultWeights);

    Map<String, int> dpsIncrease = {};
    for (final item in items) {
      int dpsIncreaseValue = calculateTotalStats(item, defaultWeights) - currentStats;
      dpsIncrease[item.name] = dpsIncreaseValue;
    }

    return dpsIncrease;
  }
}
