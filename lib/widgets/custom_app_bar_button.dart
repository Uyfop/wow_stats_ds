import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';

class  CustomAppBarButton extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomAppBarButton({
    super.key,
    required this.message,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: Tooltip(
        message: message,
        child: Container(
          decoration: BoxDecoration(
            color: appBarButtonColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: appBarShadowContainerColor,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
