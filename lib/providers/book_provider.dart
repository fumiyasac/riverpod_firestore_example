import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/book.dart';
import '../repositories/book_repository.dart';

part 'book_provider.g.dart';

@riverpod
class BookProvider extends _$BookProvider {
  @override
  FutureOr<List<Book>> build() async {
    return ref.watch(bookRepositoryProvider.future);
  }

  Future<void> addBook(String title, String author, String userId) async {
    await ref.read(bookRepositoryProvider.notifier).addBook(
        title, author, userId);
  }

  Future<void> updateBook(String bookId, String title, String author) async {
    await ref.read(bookRepositoryProvider.notifier).updateBook(
        bookId, title, author);
  }

  Future<void> deleteBook(String bookId) async {
    await ref.read(bookRepositoryProvider.notifier).deleteBook(bookId);
  }
}