import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 自動生成されたファイルの読み込みをする
part 'comment.freezed.dart';
part 'comment.g.dart';

// コードを自動生成をするために「@freezed」を記述する
@freezed
class Comment with _$Comment {

  // プロパティを定義する
  const factory Comment({
    required String id,
    required String bookId,
    required String userId,
    required String content,
    required DateTime createdAt,
  }) = _Comment;

  // JSON形式で受け取るためのコードを定義する
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  // Firestoreからデータを受け取ってJSON形式に変換する
  factory Comment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Comment.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
