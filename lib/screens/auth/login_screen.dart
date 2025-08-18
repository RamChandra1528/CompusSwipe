import 'package:flutter/material.dart';
import 'package:campus_swipe/constants/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, size: 64, color: AppTheme.primaryColor),
            SizedBox(height: 16),
            Text('Login Screen - Coming Soon'),
            Text('This will contain login/signup functionality'),
          ],
        ),
      ),
    );
  }
}
