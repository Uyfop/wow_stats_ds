import 'package:wow_stats_ds/models/enums/item_type_enum.dart';

class Item {
  final String name;
  final String type;
  final int intellect;
  final int stamina;
  final int spirit;
  final int criticalStrikeChance;
  final int hasteRating;
  final int hitRating;
  final int mastery;
  final int expertiseRating;
  final int strength;
  final int agility;
  final String imageUrl;


  Item({
    required this.name,
    required this.type,
    required this.intellect,
    required this.stamina,
    required this.spirit,
    required this.criticalStrikeChance,
    required this.hasteRating,
    required this.hitRating,
    required this.mastery, 
    required this.imageUrl,
    required this.expertiseRating,
    required this.strength,
    required this.agility,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'intellect': intellect,
      'stamina': stamina,
      'spirit': spirit,
      'criticalStrikeChance': criticalStrikeChance,
      'hasteRating': hasteRating,
      'hitRating': hitRating,
      'mastery': mastery,
      'imageUrl': imageUrl,
      'expertiseRating': expertiseRating,
      'strength': strength,
      'agility': agility,
    };
  }

 factory Item.fromJson(Map<String, dynamic> json) {
  return Item(
    name: json['name'] ?? '',
    type: json['type'] ?? '',
    intellect: json['intellect'] ?? 0,
    stamina: json['stamina'] ?? 0,
    spirit: json['spirit'] ?? 0,
    criticalStrikeChance: json['criticalStrikeChance'] ?? 0,
    hasteRating: json['hasteRating'] ?? 0,
    hitRating: json['hitRating'] ?? 0,
    mastery: json['mastery'] ?? 0,
    imageUrl: json['imageUrl'] ?? 'assets/item_img/empty_slot.jpg',
    expertiseRating: json['expertiseRating'] ?? 0,
    strength: json['strength'] ?? 0,
    agility: json['agility'] ?? 0,
  );
}

  static Item empty(ItemType type) {
    return Item(
      name: '',
      type: type.toString(),
      intellect: 0,
      stamina: 0,
      spirit: 0,
      criticalStrikeChance: 0,
      hasteRating: 0,
      hitRating: 0,
      mastery: 0,
      imageUrl: 'assets/item_img/empty_slot.jpg',
      expertiseRating: 0,
      strength: 0,
      agility: 0,
    );
  }
}
