import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/simulation/simulation.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class MageSimulationData extends SimulationData {
  final AbilityService _abilityService = AbilityService();

  @override
  Future<List<Ability>> getAbilities() async {
    return _abilityService.getAbilitiesForClass('Mage');
  }

  @override
  Future<double> runSimulation() async {
    final abilities = await getAbilities();
    int simulationlength = 60;
    double dps = 0;
  //itemy powinny sie wliczac + innaczej powinno byc okreslany cooldown itd
    while (simulationlength > 0) {
      if(await _abilityService.checkAbilityExists(abilities[0].name)) {
        int cooldown = abilities[0].cooldown;
        dps += abilities[0].dps;
        simulationlength -= cooldown;
      }
    }
    print('Running mage simulation');
    print(abilities);

  
    return dps;
  }
}
