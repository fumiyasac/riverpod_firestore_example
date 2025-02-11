import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/book.dart';

part 'book_repository.g.dart';

@riverpod
BookRepository bookRepository(BookRepositoryRef ref) {
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

  Future<void> addBook(String title, String author, String userId) async {
    await _firestore.collection('books').add({
      'title': title,
      'author': author,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateBook(String id, String title, String author) async {
    await _firestore.collection('books').doc(id).update({
      'title': title,
      'author': author,
    });
  }

  Future<void> deleteBook(String id) async {
    await _firestore.collection('books').doc(id).delete();
  }
}