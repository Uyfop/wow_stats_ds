import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';

class BuildItemWidget extends StatelessWidget {
  final Item item;
  final int index;
  final Function(Item, int) onTap;

  BuildItemWidget({
    super.key, 
    required this.item,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(item, index),
      child: Column(
        children: [
          SizedBox(
            height: 64,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: 'assets/item_img/empty_slot.jpg',
                  image: item.imageUrl,
                  height: 64,
                  width: 64,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/item_img/empty_slot.jpg',
                      height: 64,
                      width: 64,
                    );
                  },
                ),
                Text(
                  item.name.isEmpty ? 'Empty Slot' : item.name,
                  style: charaTextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
