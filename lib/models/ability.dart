import 'package:wow_stats_ds/models/enums/class_enum.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';

class Ability {
  final String name;
  final int dps;
  final int cooldown;
  final String description;
  CharacterClass classType;

  Ability({
    required this.name,
    required this.dps,
    required this.cooldown,
    required this.description, 
    required this.classType,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dps': dps,
      'cooldown': cooldown,
      'description': description,
      'classType': classType.name,
    };
  }

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['name'],
      dps: json['dps'],
      cooldown: json['cooldown'],
      description: json['description'], 
      classType: CharacterClassExtension.fromString(json['classType']),
    );
  }
}
