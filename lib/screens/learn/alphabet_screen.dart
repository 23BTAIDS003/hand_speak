import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({Key? key}) : super(key: key);

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  List<String> alphabetImages = [];

  @override
  void initState() {
    super.initState();
    _loadAlphabetAssets();
  }

  Future<void> _loadAlphabetAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/alphabet/') && (key.endsWith('.png') || key.endsWith('.jpg')))
        .toList();

    setState(() {
      alphabetImages = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alphabets'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: alphabetImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final path = alphabetImages[index];
            final name = path.split('/').last.split('.').first;

            return Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(path, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 4),
                Text(name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            );
          },
        ),
      ),
    );
  }
}
