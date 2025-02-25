import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 自動生成されたファイルの読み込みをする
part 'book.freezed.dart';
part 'book.g.dart';

// コードを自動生成をするために「@freezed」を記述する
@freezed
class Book with _$Book {

  // プロパティを定義する
  const factory Book({
    required String id,
    required String title,
    required String author,
    required String summary,
    required String isbn,
    required String userId,
    required DateTime createdAt,
  }) = _Book;

  // JSON形式で受け取るためのコードを定義する
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  // Firestoreからデータを受け取ってJSON形式に変換する
  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
