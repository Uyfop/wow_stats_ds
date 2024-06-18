import 'package:wow_stats_ds/models/enums/class_enum.dart';

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}

extension CharacterClassExtension on CharacterClass {
  String get name {
    switch (this) {
      case CharacterClass.warrior:
        return 'Warrior';
      case CharacterClass.mage:
        return 'Mage';
      case CharacterClass.rogue:
        return 'Rogue';
      case CharacterClass.priest:
        return 'Priest';
      case CharacterClass.paladin:
        return 'Paladin';
      case CharacterClass.hunter:
        return 'Hunter';
      case CharacterClass.warlock:
        return 'Warlock';
      case CharacterClass.shaman:
        return 'Shaman';
      case CharacterClass.druid:
        return 'Druid';
      case CharacterClass.deathKnight:
        return 'Death Knight';
    }
  }

  static CharacterClass fromString(String name) {
    switch (name) {
      case 'Warrior':
        return CharacterClass.warrior;
      case 'Mage':
        return CharacterClass.mage;
      case 'Rogue':
        return CharacterClass.rogue;
      case 'Priest':
        return CharacterClass.priest;
      case 'Paladin':
        return CharacterClass.paladin;
      case 'Hunter':
        return CharacterClass.hunter;
      case 'Warlock':
        return CharacterClass.warlock;
      case 'Shaman':
        return CharacterClass.shaman;
      case 'Druid':
        return CharacterClass.druid;
      case 'Death Knight':
        return CharacterClass.deathKnight;
      default:
        throw ArgumentError('Invalid character class name: $name');
    }
  }
}

