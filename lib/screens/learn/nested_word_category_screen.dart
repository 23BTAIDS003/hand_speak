import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class NestedWordCategoryScreen extends StatefulWidget {
  final String category;

  const NestedWordCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<NestedWordCategoryScreen> createState() => _NestedWordCategoryScreenState();
}

class _NestedWordCategoryScreenState extends State<NestedWordCategoryScreen> {
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final paths = manifestMap.keys
        .where((String key) =>
    key.contains('assets/words/${widget.category.toLowerCase()}/') &&
        (key.endsWith('.png') || key.endsWith('.jpg') || key.endsWith('.gif')))
        .toList();

    setState(() {
      imagePaths = paths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.deepPurple,
      ),
      body: imagePaths.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: imagePaths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final path = imagePaths[index];
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
                  name.replaceAll('_', ' ').toUpperCase(),
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
