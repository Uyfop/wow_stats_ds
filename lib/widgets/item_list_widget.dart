import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/models/extensions/item_utils.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/service/item_service.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemService itemService = ItemService();

    return StreamBuilder<List<Item>>(
      stream: itemService.getItems(),
      builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
        List<Item> items = snapshot.data ?? [];
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            Item item = items[index];
            String tooltipMessage = generateTooltipMessage(item);
            return MouseRegion(
              child: Tooltip(
                message: tooltipMessage,
                child: ListTile(             
                  hoverColor: homePageHoverColor,
                  textColor: homePageTextColor,
                  leading: Image.asset(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image);
                    },
                  ),
                  title: Text(item.name),
                ),
              ),
            );
          },
        );
      }
      },
    );
  }
}
