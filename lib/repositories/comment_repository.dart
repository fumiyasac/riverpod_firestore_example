import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/comment.dart';

part 'comment_repository.g.dart';

@riverpod
class CommentRepository extends _$CommentRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Comment>> build(String bookId) async {
    return getComments(bookId);
  }

  Future<List<Comment>> getComments(String bookId) async {
    final snapshot = await _firestore
        .collection('comments')
        .where('bookId', isEqualTo: bookId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList();
  }

  Future<void> addComment(String bookId, String userId, String content) async {
    await _firestore.collection('comments').add({
      'bookId': bookId,
      'userId': userId,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
    ref.invalidateSelf();
  }
}

