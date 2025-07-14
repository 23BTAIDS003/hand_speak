import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHelpSection(
              'Getting Started',
              'Welcome to HandSpeak! This app helps you learn and translate sign language easily.',
              Icons.start,
            ),
            const SizedBox(height: 20),
            _buildHelpSection(
              'Learning Mode',
              'Browse through our comprehensive library of sign language gestures. Practice at your own pace with interactive lessons.',
              Icons.school,
            ),
            const SizedBox(height: 20),
            _buildHelpSection(
              'Translation Mode',
              'Use your camera to translate sign language in real-time. You can also translate text to sign language animations.',
              Icons.translate,
            ),
            const SizedBox(height: 20),
            _buildHelpSection(
              'Practice Mode',
              'Test your knowledge with our practice mode. Get instant feedback on your signing accuracy.',
              Icons.fitness_center,
            ),
            const SizedBox(height: 20),
            _buildHelpSection(
              'Settings',
              'Customize your learning experience. Adjust camera settings, notification preferences, and more.',
              Icons.settings,
            ),
            const SizedBox(height: 20),
            _buildContactSupport(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpSection(String title, String description, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: Colors.blue),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSupport(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need More Help?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Our support team is here to help you with any questions or issues you may have.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement contact support functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Support feature coming soon!'),
                  ),
                );
              },
              child: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }
}