import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/book.dart';

part 'book_repository.g.dart';

@riverpod
class BookRepository extends _$BookRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Book>> build() async {
    return getBooks();
  }

  Future<List<Book>> getBooks() async {
    final snapshot = await _firestore.collection('books').orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
  }

  Future<void> addBook(String title, String author, String userId) async {
    await _firestore.collection('books').add({
      'title': title,
      'author': author,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    });
    ref.invalidateSelf();
  }

  Future<void> updateBook(String bookId, String title, String author) async {
    await _firestore.collection('books').doc(bookId).update({
      'title': title,
      'author': author,
    });
    ref.invalidateSelf();
  }

  Future<void> deleteBook(String bookId) async {
    await _firestore.collection('books').doc(bookId).delete();
    ref.invalidateSelf();
  }
}