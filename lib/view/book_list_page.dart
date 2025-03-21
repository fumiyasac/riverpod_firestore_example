import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/book_view_model.dart';
import 'add_book_page.dart';
import 'book_detail_page.dart';

class BookListPage extends ConsumerWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(bookViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('おすすめ参考書一覧'),
      ),
      body: booksAsync.when(
        data: (books) => ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              leading: Image.network(
                'https://ndlsearch.ndl.go.jp/thumbnail/${book.isbn}.jpg',
                fit: BoxFit.fitHeight,
                height: 40,
              ),
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(book: book),
                ),
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBookPage()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}