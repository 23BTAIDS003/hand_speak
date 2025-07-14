import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../common/sign_detail_screen.dart'; // ✅ Ensure this path is correct

class PhrasesScreen extends StatefulWidget {
  const PhrasesScreen({super.key});

  @override
  State<PhrasesScreen> createState() => _PhrasesScreenState();
}

class _PhrasesScreenState extends State<PhrasesScreen> {
  List<String> phraseImages = [];

  @override
  void initState() {
    super.initState();
    _loadPhraseAssets();
  }

  Future<void> _loadPhraseAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) =>
    key.contains('assets/phrases/') &&
        (key.endsWith('.png') || key.endsWith('.jpg') || key.endsWith('.gif')))
        .toList();

    setState(() {
      phraseImages = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phrases'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: phraseImages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount: phraseImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final path = phraseImages[index];
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
                    name.replaceAll('_', ' ').toUpperCase(),
                    textAlign: TextAlign.center,
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
