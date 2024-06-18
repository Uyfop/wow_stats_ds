

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
