import 'package:flutter/material.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          'Question signs will be shown here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
