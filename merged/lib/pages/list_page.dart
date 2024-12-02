import 'package:flutter/material.dart';
import 'package:merged/main.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;

class ComicListPage extends StatefulWidget {
  const ComicListPage({super.key});

  @override
  _ComicListPageState createState() => _ComicListPageState();
}

class _ComicListPageState extends State<ComicListPage> {
  List<dynamic> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    const url = 'https://openlibrary.org/search.json?q=comics'; // Пошук "comics"
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _books = data['docs'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialogMessage(context, 'Error', 'Failed to fetch books: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _books.length,
      itemBuilder: (context, index) {
        final book = _books[index];
        return ListTile(
          title: Text(book['title'] ?? 'Unknown Title'),
          subtitle: Text(book['author_name']?.join(', ') ?? 'Unknown Author'),
          onTap: () {
            // Додайте дію, наприклад, перехід на деталі книги
          },
        );
      },
    );
  }
}
