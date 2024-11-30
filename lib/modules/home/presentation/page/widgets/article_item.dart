import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final String storyTitle;
  final String author;
  final DateTime createdAt;

  const ArticleItem({
    super.key,
    required this.storyTitle,
    required this.author,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storyTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By $author',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                ),
                Text(
                  '${createdAt.day}/${createdAt.month}/${createdAt.year}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
