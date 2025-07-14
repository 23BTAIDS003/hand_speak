import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../common/sign_detail_screen.dart';// <-- Make sure this path is correct

class GreetingsScreen extends StatefulWidget {
  const GreetingsScreen({super.key});

  @override
  State<GreetingsScreen> createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends State<GreetingsScreen> {
  List<String> greetingImages = [];

  @override
  void initState() {
    super.initState();
    _loadGreetingAssets();
  }

  Future<void> _loadGreetingAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) =>
    key.contains('assets/greetings/') &&
        (key.endsWith('.png') ||
            key.endsWith('.jpg') ||
            key.endsWith('.gif')))
        .toList();

    setState(() {
      greetingImages = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greetings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: greetingImages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount: greetingImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final path = greetingImages[index];
            final name = path.split('/').last.split('.').first;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SignDetailScreen(
                      assetPath: path,
                      title: name,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(path, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
