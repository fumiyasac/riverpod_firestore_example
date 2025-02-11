import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/comment.dart';

part 'comment_repository.g.dart';

@riverpod
CommentRepository commentRepository(CommentRepositoryRef ref) {
  return CommentRepository(FirebaseFirestore.instance);
}

class CommentRepository {
  final FirebaseFirestore _firestore;

  CommentRepository(this._firestore);

  Future<List<Comment>> getComments(String bookId) async {
    final snapshot = await _firestore
        .collection('comments')
        // MEMO: このままだとエラーとなるので、インデックスを追加する必要有
        // 👉 エラーメッセージに表示されているリンクを押下して設定する
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
  }
}

