import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/widgets/appbar_widget.dart';
import 'package:wow_stats_ds/widgets/character_leaderboard_widget.dart';


class LeaderBoardPage extends StatelessWidget {
  LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: siteBackgroundColor,
      body: Center(
        child: Container(
          width: 600,
          height: 500,
           decoration: BoxDecoration(
            color: leadeBordContainerColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: leaderboardShadowContainerColor,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ], 
          ),
          child: Column(
            children: [
               const Row(
                children: [
      
                  SizedBox(width: 18),
                  Text(
                      "Rank",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                     
                   SizedBox(width: 140),
                  Text(
                      "Name",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  
                  SizedBox(width: 130),
                  Text(
                      "DPS",  
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),                  
                ],
              ),
              Expanded(
                child: CharacterLeaderBoardWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}