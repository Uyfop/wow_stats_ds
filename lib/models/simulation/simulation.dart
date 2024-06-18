import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/item.dart';

abstract class SimulationData {
  Future<List<Ability>> getAbilities();
  Future<double> runSimulation(Character character);
  Map<String, int> calculateDPSIncrease(List<Item> items, Item currentItem);
  Map<String, int> get defaultStatWeights => {
    'intellect': 1,
    'stamina': 1,
    'spirit': 1,
    'strength': 1,
    'hasteRating': 1,
    'hitRating': 1,
    'mastery': 1,
    'critRating': 1,
    'expertiseRating': 1,
    'agility': 1,
  };
  int calculateTotalStats(Item item, Map<String, int> weights) {
    return item.intellect * weights['intellect']! +
            item.stamina * weights['stamina']! +
            item.spirit * weights['spirit']! +
            item.strength * weights['strength']! +
            item.hasteRating * weights['hasteRating']! +
            item.hitRating * weights['hitRating']! +
            item.mastery * weights['mastery']! +
            item.criticalStrikeChance * weights['critRating']! +
            item.agility * weights['agility']! +
            item.expertiseRating * weights['expertiseRating']!;
  }  
}
  

