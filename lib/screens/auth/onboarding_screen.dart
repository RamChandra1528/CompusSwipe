import 'package:flutter/material.dart';
import 'package:campus_swipe/constants/app_theme.dart';
import 'package:campus_swipe/screens/auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // App Name
                    Text(
                      'CampusSwipe',
                      style: AppTheme.headingStyle.copyWith(
                        fontSize: 36,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Description
                    Text(
                      'Connect with verified students from your college. Build meaningful relationships in a safe and authentic environment.',
                      style: AppTheme.bodyStyle.copyWith(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Features
                    _buildFeature(
                      icon: Icons.verified_user,
                      title: 'Verified Profiles',
                      description: 'All users are verified with college credentials',
                    ),
                    
                    const SizedBox(height: 24),
                    
                    _buildFeature(
                      icon: Icons.security,
                      title: 'Safe Environment',
                      description: 'Admin-moderated platform with strict guidelines',
                    ),
                    
                    const SizedBox(height: 24),
                    
                    _buildFeature(
                      icon: Icons.chat,
                      title: 'Real-time Chat',
                      description: 'Connect instantly with your matches',
                    ),
                  ],
                ),
              ),
              
              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.subheadingStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTheme.captionStyle.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
