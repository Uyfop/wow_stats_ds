import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/simulation/simulation.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class DeathKnightSimulationData extends SimulationData {
  final AbilityService _abilityService = AbilityService();

  @override
 Future<List<Ability>> getAbilities() async {
    return _abilityService.getAbilitiesForClass('Death Knight');
  }


  @override
 Future<double> runSimulation() async {
    double dps = 1;
    return dps;
  }

}