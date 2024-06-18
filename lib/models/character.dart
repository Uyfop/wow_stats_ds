import 'package:wow_stats_ds/models/enums/class_enum.dart';
import 'package:wow_stats_ds/models/enums/item_type_enum.dart';
import 'package:wow_stats_ds/models/extensions/string_extension.dart';
import 'package:wow_stats_ds/models/item.dart';

class Character {
  String name;
  String userId;
  Item? head;
  Item? neck;
  Item? shoulder;
  Item? back;
  Item? chest;
  Item? wrist;
  Item? hands;
  Item? waist;
  Item? legs;
  Item? feet;
  Item? finger1;
  Item? finger2;
  Item? trinket1;
  Item? trinket2;
  Item? mainHand;
  Item? offHand;
  Item? ranged;
  CharacterClass classType;

  Character({
    required this.name,
    required this.userId,
    this.head,
    this.neck,
    this.shoulder,
    this.back,
    this.chest,
    this.wrist,
    this.hands,
    this.waist,
    this.legs,
    this.feet,
    this.finger1,
    this.finger2,
    this.trinket1,
    this.trinket2,
    this.mainHand,
    this.offHand,
    this.ranged,
    required this.classType

  });

  String get capitalizedClassName => classType.name.capitalize();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userId': userId,
      'head': head?.toJson(),
      'neck': neck?.toJson(),
      'shoulder': shoulder?.toJson(),
      'back': back?.toJson(),
      'chest': chest?.toJson(),
      'wrist': wrist?.toJson(),
      'hands': hands?.toJson(),
      'waist': waist?.toJson(),
      'legs': legs?.toJson(),
      'feet': feet?.toJson(),
      'finger1': finger1?.toJson(),
      'finger2': finger2?.toJson(),
      'trinket1': trinket1?.toJson(),
      'trinket2': trinket2?.toJson(),
      'mainHand': mainHand?.toJson(),
      'offHand': offHand?.toJson(),
      'ranged': ranged?.toJson(),
      'classType': classType.name,
    };
  }

 factory Character.fromJson(Map<String, dynamic> json) {
  return Character(
    name: json['name'],
    userId: json['userId'],
    head: json['head'] != null ? Item.fromJson(json['head']) : Item.empty(ItemType.head),
    neck: json['neck'] != null ? Item.fromJson(json['neck']) : Item.empty(ItemType.neck),
    shoulder: json['shoulder'] != null ? Item.fromJson(json['shoulder']) : Item.empty(ItemType.shoulder),
    back: json['back'] != null ? Item.fromJson(json['back']) : Item.empty(ItemType.back),
    chest: json['chest'] != null ? Item.fromJson(json['chest']) : Item.empty(ItemType.chest),
    wrist: json['wrist'] != null ? Item.fromJson(json['wrist']) : Item.empty(ItemType.wrist),
    hands: json['hands'] != null ? Item.fromJson(json['hands']) : Item.empty(ItemType.hands),
    waist: json['waist'] != null ? Item.fromJson(json['waist']) : Item.empty(ItemType.waist),
    legs: json['legs'] != null ? Item.fromJson(json['legs']) : Item.empty(ItemType.legs),
    feet: json['feet'] != null ? Item.fromJson(json['feet']) : Item.empty(ItemType.feet),
    finger1: json['finger1'] != null ? Item.fromJson(json['finger1']) : Item.empty(ItemType.finger1),
    finger2: json['finger2'] != null ? Item.fromJson(json['finger2']) : Item.empty(ItemType.finger2),
    trinket1: json['trinket1'] != null ? Item.fromJson(json['trinket1']) : Item.empty(ItemType.trinket1),
    trinket2: json['trinket2'] != null ? Item.fromJson(json['trinket2']) : Item.empty(ItemType.trinket2),
    mainHand: json['mainHand'] != null ? Item.fromJson(json['mainHand']) : Item.empty(ItemType.mainHand),
    offHand: json['offHand'] != null ? Item.fromJson(json['offHand']) : Item.empty(ItemType.offHand),
    ranged: json['ranged'] != null ? Item.fromJson(json['ranged']) : Item.empty(ItemType.ranged), 
    classType: CharacterClassExtension.fromString(json['classType']),
  );
}

  Map<String, int> getStats() {
    final stats = <String, int>{
      'intellect': 0,
      'stamina': 0,
      'spirit': 0,
      'criticalStrikeChance': 0,
      'hasteRating': 0,
      'hitRating': 0,
      'mastery': 0,
    };

    final items = [
      head,
      neck,
      shoulder,
      back,
      chest,
      wrist,
      hands,
      waist,
      legs,
      feet,
      finger1,
      finger2,
      trinket1,
      trinket2,
      mainHand,
      offHand,
      ranged,
    ];

    for (final item in items) {
      if (item != null) {
        stats['intellect'] = stats['intellect']! + item.intellect;
        stats['stamina'] = stats['stamina']! + item.stamina;
        stats['spirit'] = stats['spirit']! + item.spirit;
        stats['criticalStrikeChance'] = stats['criticalStrikeChance']! + item.criticalStrikeChance;
        stats['hasteRating'] = stats['hasteRating']! + item.hasteRating;
        stats['hitRating'] = stats['hitRating']! + item.hitRating;
        stats['mastery'] = stats['mastery']! + item.mastery;
      }
    }

    return stats;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Character otherCharacter = other as Character;
    return name == otherCharacter.name && userId == otherCharacter.userId;
  }

  @override
  int get hashCode => name.hashCode ^ userId.hashCode;

}
