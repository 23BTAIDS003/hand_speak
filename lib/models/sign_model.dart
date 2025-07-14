class SignLesson {
  final String id;
  final String category; // 'Alphabets', 'Numbers', 'Words'
  final String title;
  final String description;
  final String imageUrl;
  final String animationUrl;
  final String audioUrl;
  final bool isCompleted;

  SignLesson({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.animationUrl,
    required this.audioUrl,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'animationUrl': animationUrl,
      'audioUrl': audioUrl,
      'isCompleted': isCompleted,
    };
  }

  factory SignLesson.fromMap(Map<String, dynamic> map) {
    return SignLesson(
      id: map['id'],
      category: map['category'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      animationUrl: map['animationUrl'],
      audioUrl: map['audioUrl'],
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}