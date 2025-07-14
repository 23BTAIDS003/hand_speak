// lib/common/sign_detail_screen.dart

import 'package:flutter/material.dart';

class SignDetailScreen extends StatelessWidget {
  final String assetPath;
  final String title;

  const SignDetailScreen({
    Key? key,
    required this.assetPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGif = assetPath.toLowerCase().endsWith('.gif');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isGif
                ? Image.asset(assetPath)
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                assetPath,
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
