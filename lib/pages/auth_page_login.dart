import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/pages/auth_page_password_reset.dart';
import 'package:wow_stats_ds/pages/auth_page_register.dart';
import 'package:wow_stats_ds/pages/my_home_page.dart';
import 'package:wow_stats_ds/service/auth_service.dart';
import 'package:wow_stats_ds/widgets/auth_form_widget.dart';

class AuthPageLogin extends StatefulWidget {
  const AuthPageLogin({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPageLogin> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siteBackgroundColor,
      appBar: AppBar(
        title: const Text('Login Page'),
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
              authForm(_emailController, _passwordController),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: authButtonStyle(),
                icon: const Icon(Icons.lock_open, size: 32),
                label: const Text('Login'),
                onPressed: () async {
                  User? user = await _auth.signIn(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  }
                },
              ),
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'New wowEnjoyer?', 
                        style: TextStyle(color: siteTextColor),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AuthPageRegister()),
                          );
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(color: siteTextColor),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: siteTextColor),
                    ),
                  ), 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}




