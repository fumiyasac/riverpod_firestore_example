import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_firestore_example/models/comment.dart';
import 'package:riverpod_firestore_example/repositories/comment_repository.dart';
import 'package:riverpod_firestore_example/view_models/book_view_model.dart';
import 'package:riverpod_firestore_example/view_models/comment_view_model.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late CommentRepository commentRepository;
  late ProviderContainer container;

  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();
    // テスト用のデータを事前に追加
    await fakeFirestore.collection('comments').add({
      'id': '1',
      'bookId': '9999',
      'content': 'Test Content No.1',
      'userId': 'exampleUserId',
      'createdAt': DateTime.now(),
    });
    await fakeFirestore.collection('comments').add({
      'id': '2',
      'bookId': '10000',
      'content': 'Test Content No.2',
      'userId': 'exampleUserId',
      'createdAt': DateTime.now(),
    });
    await fakeFirestore.collection('comments').add({
      'id': '3',
      'bookId': '9999',
      'content': 'Test Content No.3',
      'userId': 'exampleUserId',
      'createdAt': DateTime.now(),
    });
    commentRepository = CommentRepository(fakeFirestore);
    container = ProviderContainer(
      overrides: [
        commentRepositoryProvider.overrideWith((ref) => commentRepository),
      ],
    );
  });

  group('CommentViewModel with FakeFirestore Tests', () {
    test('should load comment from Firestore', () async {
      final bookId = '9999';
      final commentAsync = container.read(commentViewModelProvider(bookId));
      expect(commentAsync, isA<AsyncLoading<List<Comment>>>());
      final comments = await container.read(commentViewModelProvider(bookId).future);
      expect(comments, isNotEmpty);
      expect(comments.first.content, 'Test Content No.3');
    });

    test('should add book to Firestore', () async {
      final bookId = '9999';
      await container.read(commentViewModelProvider(bookId).notifier)
          .addComment(bookId, 'exampleUserId', 'New Content');
      final querySnapshot = await fakeFirestore.collection('comments')
          .where('content', isEqualTo: 'New Content')
          .get();
      expect(querySnapshot.docs, hasLength(1));
      expect(querySnapshot.docs.first.data()['bookId'], '9999');
      expect(querySnapshot.docs.first.data()['userId'], 'exampleUserId');
    });
  });
}