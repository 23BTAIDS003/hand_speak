import 'package:flutter/material.dart';
import '../widgets/gesture_card.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'title': 'Alphabet', 'icon': Icons.abc, 'route': '/alphabet'},
    {'title': 'Numbers', 'icon': Icons.numbers, 'route': '/numbers'},
    {'title': 'Greetings', 'icon': Icons.waving_hand, 'route': '/greetings'},
    {'title': 'Basic Words', 'icon': Icons.language, 'route': '/basic-words'},
    {'title': 'Phrases', 'icon': Icons.message, 'route': '/phrases'},
    {'title': 'Questions', 'icon': Icons.question_answer, 'route': '/questions'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Learn"),
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final item = _categories[index];
                  return GestureCard(
                    title: item['title'],
                    icon: item['icon'],
                    onTap: () => Navigator.pushNamed(context, item['route']),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
