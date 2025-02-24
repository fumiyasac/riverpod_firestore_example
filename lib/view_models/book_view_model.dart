import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_firestore_example/repositories/comment_repository.dart';
import '../models/book.dart';
import '../repositories/book_repository.dart';

part 'book_view_model.g.dart';

@riverpod
class BookViewModel extends _$BookViewModel {
  @override
  Future<List<Book>> build() async {
    return ref.watch(bookRepositoryProvider).getBooks();
  }

  Future<void> addBook(String title, String author, String summary, String isbn, String userId) async {
    await ref.read(bookRepositoryProvider).addBook(title, author, summary, isbn, userId);
    ref.invalidateSelf();
  }

  Future<void> deleteBook(String id) async {
    await ref.read(bookRepositoryProvider).deleteBook(id);
    await ref.read(commentRepositoryProvider).deleteComment(id);
    ref.invalidateSelf();
  }
}