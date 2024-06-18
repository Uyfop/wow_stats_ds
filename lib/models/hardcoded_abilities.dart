import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/enums/class_enum.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class AbilityManager {
  final AbilityService _abilityService = AbilityService();

  Future<void> addAbilities() async {
    final ability1 = Ability(
      name: 'Mighty Strike',
      dps: 100,
      cooldown: 10,
      description: 'A powerful strike that deals massive damage.',
      classType: CharacterClass.warrior,
    );

    final ability2 = Ability(
      name: 'Fireball',
      dps: 120,
      cooldown: 8,
      description: 'Launches a fiery projectile at the target.',
      classType: CharacterClass.mage,
    );
    await addAbilityIfNotExists(ability1);
    await addAbilityIfNotExists(ability2);
  }

  Future<void> addAbilityIfNotExists(Ability ability) async {
    final exists = await _abilityService.checkAbilityExists(ability.name);
    if (!exists) {
      await _abilityService.addAbility(ability);
    }
  }
}
