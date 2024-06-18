
import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';

Widget authForm (TextEditingController emailController, TextEditingController passwordController) { 
    return Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        authTextField(emailController, 'Email', false),
        const SizedBox(height: 16),
        authTextField(passwordController, 'Password', true),
      ],
    );
}