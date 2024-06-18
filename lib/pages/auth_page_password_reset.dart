import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/service/auth_service.dart';

class AuthForgotPasswordPage extends StatefulWidget {
  const AuthForgotPasswordPage({super.key});

  @override
  _AuthForgotPasswordPageState createState() => _AuthForgotPasswordPageState();
}

class _AuthForgotPasswordPageState extends State<AuthForgotPasswordPage> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siteBackgroundColor,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16.0),
          decoration: authBoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              authTextField(_emailController, 'Email', false),
              const SizedBox(height: 20),
              ElevatedButton(
                style: authButtonStyle(),
                onPressed: () async {
                  await _auth.resetPassword(_emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Send Password Reset Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
