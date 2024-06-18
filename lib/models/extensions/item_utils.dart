import 'package:wow_stats_ds/models/item.dart';

String generateTooltipMessage(Item item) {
    String tooltipMessage = '';

    if (item.intellect != 0) {
      tooltipMessage += 'Intellect: ${item.intellect}\n';
    }
    if (item.stamina != 0) {
      tooltipMessage += 'Stamina: ${item.stamina}\n';
    }
    if (item.spirit != 0) {
      tooltipMessage += 'Spirit: ${item.spirit}\n';
    }
    if (item.criticalStrikeChance != 0) {
      tooltipMessage += 'Critical Strike: ${item.criticalStrikeChance}\n';
    }
    if (item.hasteRating != 0) {
      tooltipMessage += 'Haste: ${item.hasteRating}\n';
    }
    if (item.hitRating != 0) {
      tooltipMessage += 'Hit: ${item.hitRating}\n';
    }
    if (item.mastery != 0) {
      tooltipMessage += 'Mastery: ${item.mastery}\n';
    }
    tooltipMessage += 'Type: ${item.type}';

    return tooltipMessage;
  }

  