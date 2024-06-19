
import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/models/simulation/simulation.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class RogueSimulationData extends SimulationData {
  final AbilityService _abilityService = AbilityService();

  @override
  Future<List<Ability>> getAbilities() async {
    return _abilityService.getAbilitiesForClass('Rogue');
  }


  @override
  Future<double> runSimulation(Character character) async {
    double dps = 6;
    return dps;
  }

  @override
  Map<String, int> get defaultStatWeights => {
    'intellect': 0,
    'stamina': 0,
    'spirit': 0,
    'strength': 0,
    'hasteRating': 0,
    'hitRating': 1,
    'mastery': 0,
    'critRating': 2,
    'agility': 3,
    'expertiseRating': 1,
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