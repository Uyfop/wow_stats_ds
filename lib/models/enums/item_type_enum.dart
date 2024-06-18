

enum ItemType {
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
}


String enumToString(ItemType enumItem) {
  return enumItem.toString().split('.').last;
}


Map<String, ItemType> itemTypeMap = {
  'head': ItemType.head,
  'neck': ItemType.neck,
  'shoulder': ItemType.shoulder,
  'back': ItemType.back,
  'chest': ItemType.chest,
  'wrist': ItemType.wrist,
  'hands': ItemType.hands,
  'waist': ItemType.waist,
  'legs': ItemType.legs,
  'feet': ItemType.feet,
  'finger1': ItemType.finger1,
  'finger2': ItemType.finger2,
  'trinket1': ItemType.trinket1,
  'trinket2': ItemType.trinket2,
  'mainhand': ItemType.mainHand,
  'offhand': ItemType.offHand,
  'ranged': ItemType.ranged,
};

ItemType getItemTypeFromString(String typeString) {
  if (itemTypeMap.containsKey(typeString.toLowerCase())) {
    return itemTypeMap[typeString.toLowerCase()]!;
  } else {
    throw Exception('Invalid item type: $typeString');
  }
}