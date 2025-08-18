import 'package:flutter/material.dart';
import 'package:campus_swipe/constants/app_theme.dart';

class VerificationPendingScreen extends StatelessWidget {
  const VerificationPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pending_actions, size: 64, color: AppTheme.warningColor),
            SizedBox(height: 16),
            Text('Verification Pending'),
            Text('Your account is under review by admins'),
          ],
        ),
      ),
    );
  }
}
