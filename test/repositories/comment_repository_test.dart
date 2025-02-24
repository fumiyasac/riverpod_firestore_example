import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_firestore_example/repositories/comment_repository.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late CommentRepository repository;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    repository = CommentRepository(fakeFirestore);
  });

  group('CommentRepository', () {
    test('getComments returns list of comments', () async {
      // テストデータの準備
      final testData1 = {
        'id': '1',
        'bookId': '9999',
        'content': 'Test Content No.1',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
      };
      final testData2 = {
        'id': '2',
        'bookId': '10000',
        'content': 'Test Content No.2',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
      };
      final testData3 = {
        'id': '3',
        'bookId': '9999',
        'content': 'Test Content No.3',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
      };
      await fakeFirestore.collection('comments').doc('1').set(testData1);
      await fakeFirestore.collection('comments').doc('2').set(testData2);
      await fakeFirestore.collection('comments').doc('3').set(testData3);

      // 追加されたコメントを取得
      final books = await repository.getComments("9999");

      expect(books.length, 2);
      expect(books.first.content, 'Test Content No.3');
      expect(books.last.content, 'Test Content No.1');
    });

    test('addComment successfully adds a comment', () async {

      // 新規のコメントを作成（IDは空文字列または任意の文字列）
      await repository.addComment("9999", "exampleUserId", "New Test Content");

      // 追加された本を取得
      final comment = await repository.getComments("9999");

      expect(comment.length, 1);
      expect(comment.first.bookId, '9999');
      expect(comment.first.content, 'New Test Content');
      expect(comment.first.id.isNotEmpty, true);
    });

    test('deleteComment successfully deletes comments', () async {

      // テスト用のコメントを追加
      final testData1 = {
        'id': '1',
        'bookId': '9999',
        'content': 'Test Content No.1',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
      };
      final testData2 = {
        'id': '2',
        'bookId': '10000',
        'content': 'Test Content No.2',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
      };
      final testData3 = {
        'id': '3',
        'bookId': '9999',
        'content': 'Test Content No.3',
        'userId': 'exampleUserId',
        'createdAt': DateTime.now(),
      };
      await fakeFirestore.collection('comments').doc('1').set(testData1);
      await fakeFirestore.collection('comments').doc('2').set(testData2);
      await fakeFirestore.collection('comments').doc('3').set(testData3);

      final docRef = fakeFirestore.collection('comments');

      // 削除前の確認
      var comments = await repository.getComments('9999');
      expect(comments.length, 2);

      // コメントを削除
      await repository.deleteComment('9999');

      // 削除後の確認
      comments = await repository.getComments('9999');
      expect(comments.length, 0);

      // ドキュメントが実際に削除されたことを確認
      final docSnapshot = await fakeFirestore.collection('comments').doc(docRef.id).get();
      expect(docSnapshot.exists, false);
    });
  });
}
