import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  List<String> numberImages = [];

  @override
  void initState() {
    super.initState();
    _loadNumberAssets();
  }

  Future<void> _loadNumberAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) =>
    key.contains('assets/numbers/') &&
        (key.endsWith('.png') ||
            key.endsWith('.jpg') ||
            key.endsWith('.gif')))
        .toList();

    setState(() {
      numberImages = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Numbers'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: numberImages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount: numberImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final path = numberImages[index];
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
                Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
