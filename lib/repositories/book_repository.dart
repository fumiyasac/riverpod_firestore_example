import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/book.dart';

part 'book_repository.g.dart';

@riverpod
BookRepository bookRepository(Ref ref) {
  return BookRepository(FirebaseFirestore.instance);
}

class BookRepository {
  final FirebaseFirestore _firestore;

  BookRepository(this._firestore);

  Future<List<Book>> getBooks() async {
    final snapshot = await _firestore
        .collection('books')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
  }

  Future<void> addBook(String title, String author, String summary, String isbn, String userId) async {
    await _firestore.collection('books').add({
      'title': title,
      'author': author,
      'summary': summary,
      'isbn': isbn,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteBook(String id) async {
    await _firestore.collection('books').doc(id).delete();
  }
}