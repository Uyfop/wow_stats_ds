import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/character.dart';
import 'package:wow_stats_ds/models/extensions/item_utils.dart';
import 'package:wow_stats_ds/models/item.dart';
import 'package:wow_stats_ds/service/item_service.dart';
import 'package:wow_stats_ds/widgets/build_item_show_widget.dart';

class ItemGrid extends StatelessWidget {
  final Stream<List<Item>> itemStream;
  final ItemService itemService;
  final Character character;

  const ItemGrid({
    super.key,
    required this.itemStream,
    required this.itemService,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Item>>(
      stream: itemStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items found.'));
        } else {
          final items = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 5,
              childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 5),
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return BuildItemWidget(
                item: items[index],
                index: index,
                onTap: (item, index) {
                  showItemDialog(context, item, index, itemService, character);
                },
              );
            },
          );
        }
      },
    );
  }
}
