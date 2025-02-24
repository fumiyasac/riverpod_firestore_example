import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';
import '../view_models/book_view_model.dart';
import '../view_models/comment_view_model.dart';

class BookDetailPage extends ConsumerWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(commentViewModelProvider(book.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '📕 著者や出版情報:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                book.author,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 5,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '🏃 ‍参考書の特徴に関する情報:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Text(
                book.summary,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 5,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '🗒️ 参考書を進める際のメモ:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: commentsAsync.when(
                data: (comments) => ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comment.content),
                        SizedBox(height: 6),
                        Text('By: ${comment.userId}'),
                        SizedBox(height: 8),
                      ],
                    );
                  },
                ),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCommentDialog(context, ref),
        child: Icon(Icons.comment),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('参考書を削除'),
        content: Text('この参考書の内容を削除しますか?\n※これまで投稿されたメモも削除されますのでご注意下さい。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('削除する'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(bookViewModelProvider.notifier).deleteBook(book.id);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _showAddCommentDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('進める際のメモを追加する'),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: '例: 勉強を進めた時に「こうすればうまくいった」「この点に注意」等ををお伝えしましょう。',
            ),
            maxLines: 3,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await ref.read(commentViewModelProvider(book.id).notifier)
                    .addComment(book.id, 'currentUserId', controller.text);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: Text('新規追加する'),
          ),
        ],
      ),
    );
  }
}
