import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_firestore_example/models/book.dart';
import 'package:riverpod_firestore_example/repositories/book_repository.dart';
import 'package:riverpod_firestore_example/repositories/comment_repository.dart';
import 'package:riverpod_firestore_example/view_models/book_view_model.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late BookRepository bookRepository;
  late CommentRepository commentRepository;
  late ProviderContainer container;

  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();
    // テスト用のデータを事前に追加
    await fakeFirestore.collection('books').add({
      'id': '1',
      'title': 'Test Book No.1',
      'author': 'Test Author No.1',
      'summary': 'Test Summary No.1',
      'isbn': '1111111111111',
      'userId': 'exampleUserId',
      'createdAt': DateTime.now(),
      'comments': [],
    });
    await fakeFirestore.collection('books').add({
      'id': '2',
      'title': 'Test Book No.2',
      'author': 'Test Author No.2',
      'summary': 'Test Summary No.2',
      'isbn': '2222222222222',
      'userId': 'exampleUserId',
      'createdAt': DateTime.now(),
      'comments': [],
    });
    bookRepository = BookRepository(fakeFirestore);
    commentRepository = CommentRepository(fakeFirestore);
    container = ProviderContainer(
      overrides: [
        bookRepositoryProvider.overrideWith((ref) => bookRepository),
        commentRepositoryProvider.overrideWith((ref) => commentRepository),
      ],
    );
  });

  group('BookViewModel with FakeFirestore Tests', () {
    test('should load books from Firestore', () async {
      final booksAsync = container.read(bookViewModelProvider);
      expect(booksAsync, isA<AsyncLoading<List<Book>>>());
      final books = await container.read(bookViewModelProvider.future);
      expect(books, isNotEmpty);
      expect(books.first.title, 'Test Book No.2');
    });

    test('should add book to Firestore', () async {
      await container.read(bookViewModelProvider.notifier)
          .addBook('New Test Book', 'New Test Author', 'New Test Summary', '123456789012', 'exampleUserId');
      final querySnapshot = await fakeFirestore.collection('books')
          .where('title', isEqualTo: 'New Test Book')
          .get();
      expect(querySnapshot.docs, hasLength(1));
      expect(querySnapshot.docs.first.data()['author'], 'New Test Author');
      expect(querySnapshot.docs.first.data()['summary'], 'New Test Summary');
      expect(querySnapshot.docs.first.data()['isbn'], '123456789012');
      expect(querySnapshot.docs.first.data()['userId'], 'exampleUserId');
    });

    test('should delete book from Firestore', () async {
      final docRef = await fakeFirestore.collection('books').add({
        'id': '9999',
        'title': 'Book to Delete',
        'author': 'Author to Delete',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
      });
      await container.read(bookViewModelProvider.notifier)
          .deleteBook(docRef.id);
      final deletedBookDoc = await fakeFirestore.collection('books')
          .doc(docRef.id)
          .get();
      expect(deletedBookDoc.exists, false);
    });
  });
}