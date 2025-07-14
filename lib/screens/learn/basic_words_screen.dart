import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class NestedWordCategoryScreen extends StatefulWidget {
  final String title;
  final String folder;

  const NestedWordCategoryScreen({
    Key? key,
    required this.title,
    required this.folder,
  }) : super(key: key);

  @override
  State<NestedWordCategoryScreen> createState() => _NestedWordCategoryScreenState();
}

class _NestedWordCategoryScreenState extends State<NestedWordCategoryScreen> {
  List<String> wordImages = [];

  @override
  void initState() {
    super.initState();
    _loadCategoryAssets();
  }

  Future<void> _loadCategoryAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys
        .where((String key) =>
    key.contains('assets/words/${widget.folder.toLowerCase()}/') &&
        (key.endsWith('.png') || key.endsWith('.jpg') || key.endsWith('.gif')))
        .toList();

    setState(() {
      wordImages = imagePaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: wordImages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          itemCount: wordImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final path = wordImages[index];
            final name = path.split('/').last.split('.').first;

            return Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name.replaceAll('_', ' ').toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
