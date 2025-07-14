import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Save user's progress
  Future<void> saveUserProgress(String lessonId, int score) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("No authenticated user");

      await _firestore.collection('progress').add({
        'userId': user.uid,
        'lessonId': lessonId,
        'score': score,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error saving user progress: $e");
      rethrow;
    }
  }

  /// Get all lessons
  Future<List<Map<String, dynamic>>> getLessons() async {
    try {
      final snapshot = await _firestore.collection('lessons').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching lessons: $e");
      return [];
    }
  }

  /// Real-time user progress
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserProgressStream(String userId) {
    return _firestore
        .collection('progress')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  /// Get user progress once
  Future<List<Map<String, dynamic>>> getUserProgressOnce(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('progress')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching user progress once: $e");
      return [];
    }
  }
}
