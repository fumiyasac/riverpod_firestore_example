import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_firestore_example/repositories/book_repository.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late BookRepository repository;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    repository = BookRepository(fakeFirestore);
  });

  group('BookRepository', () {
    test('getBooks returns list of books', () async {
      // テストデータの準備
      final testData1 = {
        'id': '1',
        'title': 'Test Book No.1',
        'author': 'Test Author No.1',
        'summary': 'Test Summary No.1',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
        'comments': [],
      };
      final testData2 = {
        'id': '2',
        'title': 'Test Book No.2',
        'author': 'Test Author No.2',
        'summary': 'Test Summary No.2',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
        'comments': [],
      };
      final testData3 = {
        'id': '3',
        'title': 'Test Book No.3',
        'author': 'Test Author No.3',
        'summary': 'Test Summary No.3',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
        'comments': [],
      };
      await fakeFirestore.collection('books').doc('1').set(testData1);
      await fakeFirestore.collection('books').doc('2').set(testData2);
      await fakeFirestore.collection('books').doc('3').set(testData3);

      // 追加された本を取得
      final books = await repository.getBooks();

      expect(books.length, 3);
      expect(books.first.title, 'Test Book No.3');
      expect(books.first.author, 'Test Author No.3');
      expect(books.last.title, 'Test Book No.1');
      expect(books.last.author, 'Test Author No.1');
    });

    test('addBook successfully adds a book', () async {

      // 新規の本を作成（IDは空文字列または任意の文字列）
      await repository.addBook('New Book', 'New Author', 'New Summary', 'exampleUserId');

      // 追加された本を取得
      final books = await repository.getBooks();

      expect(books.length, 1);
      expect(books.first.title, 'New Book');
      expect(books.first.author, 'New Author');
      expect(books.first.id.isNotEmpty, true);
    });

    test('deleteBook successfully deletes a book', () async {

      // テスト用の本を追加
      final docRef = await fakeFirestore.collection('books').add({
        'title': 'Test Book',
        'author': 'Test Author',
        'summary': 'Test Summary',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
        'comments': [],
      });

      // 削除前の確認
      var books = await repository.getBooks();
      expect(books.length, 1);

      // 本を削除
      await repository.deleteBook(docRef.id);

      // 削除後の確認
      books = await repository.getBooks();
      expect(books.length, 0);

      // ドキュメントが実際に削除されたことを確認
      final docSnapshot = await fakeFirestore.collection('books').doc(docRef.id).get();
      expect(docSnapshot.exists, false);
    });
  });
}