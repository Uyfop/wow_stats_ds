import 'package:wow_stats_ds/models/ability.dart';
import 'package:wow_stats_ds/models/enums/class_enum.dart';
import 'package:wow_stats_ds/service/ability_service.dart';

class AbilityManager {
  final AbilityService _abilityService = AbilityService();

  Future<void> addAbilities() async {
    final mightStrike = Ability(
      name: 'Mighty Strike',
      dps: 100,
      cooldown: 10,
      castTime: 0,
      description: 'A powerful strike that deals massive damage.',
      classType: CharacterClass.warrior,
    );

    final fireBall = Ability(
      name: 'Fireball',
      dps: 120,
      cooldown: 2.5,
      castTime: 2.5,
      description: 'Launches a fiery projectile at the target.',
      classType: CharacterClass.mage,
    );

    final pyroBlast = Ability(
      name: 'Pyroblast',
      dps: 200,
      cooldown: 3,
      castTime: 3,
      description: 'A massive fireball that deals massive damage.',
      classType: CharacterClass.mage,
    );

    await addAbilityIfNotExists(mightStrike);
    await addAbilityIfNotExists(fireBall);
    await addAbilityIfNotExists(pyroBlast);
  }

  Future<void> addAbilityIfNotExists(Ability ability) async {
    final exists = await _abilityService.checkAbilityExists(ability.name);
    if (!exists) {
      await _abilityService.addAbility(ability);
    }
  }
}
