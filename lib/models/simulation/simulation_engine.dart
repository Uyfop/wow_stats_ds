import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/enums/class_enum.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/models/simulation/classes/deathknight_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/druid_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/hunter_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/mage_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/paladin_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/priest_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/rogue_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/shaman_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/warlock_sim.dart';
import 'package:wow_stats_ds/models/simulation/classes/warrior_sim.dart';
import 'package:wow_stats_ds/models/simulation/simulation.dart';

class SimulationEngine {
  static Future<double> runSimulation(Character character) {
    SimulationData simulationData = _getSimulationDataForClass(character.classType);
    return simulationData.runSimulation(character);
  }

  static Map<String, int> calculateDPSIncrease(List<Item> items, Item currentItem, CharacterClass characterClass) {
    SimulationData simulationData = _getSimulationDataForClass(characterClass);
    return simulationData.calculateDPSIncrease(items, currentItem);
  }

  static SimulationData _getSimulationDataForClass(CharacterClass characterClass) {
    switch (characterClass) {
      case CharacterClass.mage:
        return MageSimulationData();
      case CharacterClass.paladin:
        return PaladinSimulationData();
      case CharacterClass.priest:
        return PriestSimulationData();
      case CharacterClass.hunter:
        return HunterSimulationData();
      case CharacterClass.warrior:
        return WarriorSimulationData();
      case CharacterClass.rogue:
        return RogueSimulationData();
      case CharacterClass.warlock:  
        return WarlockSimulationData();
      case CharacterClass.shaman:
        return ShamanSimulationData();
      case CharacterClass.druid:
        return DruidSimulationData();
      case CharacterClass.deathKnight:
        return DeathKnightSimulationData();
      default:
        throw Exception('Simulation data not available for character class: $characterClass');
    }
  }
}