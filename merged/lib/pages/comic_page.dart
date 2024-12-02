import 'package:flutter/material.dart';

class ComicDetailPage extends StatelessWidget {
  final int index;
  const ComicDetailPage({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comic #$index'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                'https://m.media-amazon.com/images/M/MV5BNTkxZjhhOWItZDk1Yy00ZTBiLWE5YzgtYWU0MjAyOWQ1NjhhXkEyXkFqcGc@._V1_.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Comic #$index - Full Comic View',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}