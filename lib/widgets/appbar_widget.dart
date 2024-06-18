import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/pages/create_character_page.dart';
import 'package:wow_stats_ds/pages/create_item_page.dart';
import 'package:wow_stats_ds/pages/items_proposing_page.dart';
import 'package:wow_stats_ds/pages/leaderboard_page.dart';
import 'package:wow_stats_ds/pages/my_home_page.dart';
import 'package:wow_stats_ds/service/auth_service.dart';
import 'custom_app_bar_button.dart'; 

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  const CustomAppBar({
    super.key, 
  });
  
  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return AppBar(
      title: const Text("DS WOW Stats"),
      backgroundColor: appBarColor,
      actions: [  
        CustomAppBarButton(
          message: 'ItemProposal', 
          icon: Icons.add_shopping_cart, 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemsProposingPage()),
            );
          }
        ),
        const SizedBox(width: 12.0),
        CustomAppBarButton(
          message: 'HomePage', 
          icon: Icons.home,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }
        ),
        const SizedBox(width: 12.0),
        CustomAppBarButton(
          message: 'LeaderBoard',
          icon: Icons.leaderboard,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LeaderBoardPage()),
          ),
        ),
        const SizedBox(width: 12.0),
        CustomAppBarButton(
          message: 'Add Item',
          icon: Icons.add,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddItemPage()),
            );
          },
        ),
        const SizedBox(width: 12.0),
        CustomAppBarButton(
          message: 'Add Character',
          icon: Icons.person,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateCharacterPage()),
            );
          },
        ),
        const SizedBox(width: 12.0),
        CustomAppBarButton(
          message: 'Logout',
          icon: Icons.logout,
          onPressed: () async {
            await auth.signOut();
            Navigator.popUntil(context, ModalRoute.withName('/login'));
          },
        ),
        const SizedBox(width: 12.0),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
