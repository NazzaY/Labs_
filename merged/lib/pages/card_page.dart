import 'package:flutter/material.dart';

class ComicCard extends StatelessWidget {
  final int index;
  const ComicCard({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
              'Comic #$index',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}