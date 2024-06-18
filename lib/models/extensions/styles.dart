import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';

BoxDecoration authBoxDecoration() {
  return BoxDecoration(
    color: authContainerColor,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: authShadowContainerColor,
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

ButtonStyle authButtonStyle() {
  return ElevatedButton.styleFrom(
    foregroundColor: authButtonIconColor,
    backgroundColor: authButtonColor,
    minimumSize: const Size.fromHeight(50),
  );
}

TextField authTextField(TextEditingController emailController, String labelText, bool obscureText) {
  return TextField(
    controller: emailController,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      
    ),
    obscureText: obscureText,
  );
}

TextStyle authTextStyle() {
  return TextStyle(
    color: siteTextColor,
  );
}


TextStyle charaTextStyle() {
  return  TextStyle(
    color: siteTextColor,
  );
}


ButtonStyle charaButtonStyle() {
  return ElevatedButton.styleFrom(
    foregroundColor: charaButtonTextColor,
    backgroundColor: charaButtonColor,
    minimumSize: const Size(200, 50),
  );
}

TextStyle itemTextStyle() {
  return TextStyle(
    color: siteTextColor,
  );
}

