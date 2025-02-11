import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String userId;
  final DateTime createdAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.userId,
    required this.createdAt,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'],
      author: data['author'],
      userId: data['userId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
