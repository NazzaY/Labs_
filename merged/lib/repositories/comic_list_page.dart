import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merged/pages/book_detail_page.dart';

class ComicListPage extends StatefulWidget {
  const ComicListPage({super.key});

  @override
  State<ComicListPage> createState() => _ComicListPageState();
}

class _ComicListPageState extends State<ComicListPage> {
  Future<List<dynamic>> fetchBooks() async {
    const url = 'https://openlibrary.org/search.json?q=comics';
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await prefs.setString('books', jsonEncode(data['docs'])); 
        return data['docs'];
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      final cachedBooks = prefs.getString('books');
      if (cachedBooks != null) {
        return jsonDecode(cachedBooks);
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to load books'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        final books = snapshot.data!;
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              title: Text(book['title'] ?? 'Unknown Title'),
              subtitle: Text(book['author_name']?.join(', ') ?? 'Unknown Author'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      title: book['title'] ?? 'Unknown Title',
                      author: book['author_name']?.join(', '),
                      description: book['first_sentence']?[0],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
