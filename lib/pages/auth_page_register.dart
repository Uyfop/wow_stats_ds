import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wow_stats_ds/models/extensions/styles.dart';
import 'package:wow_stats_ds/models/extensions/colors.dart';
import 'package:wow_stats_ds/service/auth_service.dart';
import 'package:wow_stats_ds/widgets/auth_form_widget.dart';

class AuthPageRegister extends StatefulWidget {
  const AuthPageRegister({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPageRegister> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: siteBackgroundColor,
      appBar: AppBar(
        title: const Text('Sign up Page'),
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
                icon: const Icon(Icons.lock, size: 32),
                label: const Text('Sign Up'),
                onPressed: () async {
                  User? user = await _auth.register(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (user != null) {
                    Navigator.pop(context);
                  }
                },      
              ),
              const SizedBox(height: 5),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text (
                    'Already have an account?', 
                    style: authTextStyle(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: authTextStyle(),
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
