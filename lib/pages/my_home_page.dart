import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';
import 'package:wow_stats_ds/widgets/character_list_widget.dart';
import 'package:wow_stats_ds/widgets/item_list_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siteBackgroundColor,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const Expanded(
            child: ItemList(),
          ),
          Expanded(
            child: CharacterListWidget(),
          ),
        ],
      ),
    );
  }
}
