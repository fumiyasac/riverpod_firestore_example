import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/comment.dart';
import '../repositories/comment_repository.dart';

part 'comment_provider.g.dart';

@riverpod
class CommentProvider extends _$CommentProvider {
  @override
  FutureOr<List<Comment>> build(String bookId) async {
    return ref.watch(commentRepositoryProvider(bookId).future);
  }

  Future<void> addComment(String bookId, String userId, String content) async {
    await ref.read(commentRepositoryProvider(bookId).notifier).addComment(bookId, userId, content);
  }
}
