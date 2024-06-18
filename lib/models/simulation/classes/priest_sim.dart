
import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/models/simulation/simulation.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class PriestSimulationData extends SimulationData {
  final AbilityService _abilityService = AbilityService();

  @override
  Future<List<Ability>> getAbilities() async {
    return _abilityService.getAbilitiesForClass('Priest');
  }


  @override
  Future<double> runSimulation(Character character) async {
    double dps = 5;
    return dps;
  }

  @override
  Map<String, int> get defaultStatWeights => {
    'intellect': 3,
    'stamina': 0,
    'spirit': 0,
    'strength': 0,
    'hasteRating': 2,
    'hitRating': 1,
    'mastery': 0,
    'critRating': 1,
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