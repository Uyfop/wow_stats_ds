
import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/simulation/simulation.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class RogueSimulationData extends SimulationData {
  final AbilityService _abilityService = AbilityService();

  @override
 Future<List<Ability>> getAbilities() async {
    return _abilityService.getAbilitiesForClass('Rogue');
  }


  @override
 Future<double> runSimulation() async {
    double dps = 6;
    return dps;
  }

}