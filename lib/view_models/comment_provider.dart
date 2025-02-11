import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/comment.dart';
import '../repositories/comment_repository.dart';

part 'comment_provider.g.dart';

@riverpod
class CommentViewModel extends _$CommentViewModel {
  @override
  Future<List<Comment>> build(String bookId) async {
    return ref.watch(commentRepositoryProvider).getComments(bookId);
  }

  Future<void> addComment(String bookId, String userId, String content) async {
    await ref.read(commentRepositoryProvider).addComment(bookId, userId, content);
    ref.invalidateSelf();
  }
}
