import 'package:flutter/material.dart';

class SignCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final VoidCallback onTap;

  const SignCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: progress),
        ],
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
