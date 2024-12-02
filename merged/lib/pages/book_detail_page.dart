// lib/pages/book_detail_page.dart
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String? author;
  final String? description;

  const BookDetailPage({
    super.key,
    required this.title,
    this.author,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (author != null)
              Text(
                'By $author',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            const SizedBox(height: 16),
            if (description != null)
              Text(
                description!,
                style: const TextStyle(fontSize: 16),
              ),
            if (description == null)
              const Text(
                'No description available.',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ),
    );
  }
}
