// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skuadchallengue/modules/home/presentation/page/widgets/article_item.dart';

void main() {
  group('ArticleItem Widget Tests', () {
    testWidgets('displays correct story title, author, and date',
        (WidgetTester tester) async {
      const storyTitle = 'Test Story Title';
      const author = 'Test Author';
      final createdAt = DateTime(2024, 11, 15);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArticleItem(
              storyTitle: storyTitle,
              author: author,
              createdAt: createdAt,
            ),
          ),
        ),
      );

      expect(find.text(storyTitle), findsOneWidget); // Check for the title
      expect(find.text('By $author'), findsOneWidget); // Check for the author
      expect(find.text('15/11/2024'),
          findsOneWidget); // Check for the formatted date
    });

    testWidgets('truncates long story titles', (WidgetTester tester) async {
      const longStoryTitle =
          'This is a very long story title that should be truncated after two lines';
      const author = 'Test Author';
      final createdAt = DateTime(2024, 11, 15);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ArticleItem(
              storyTitle: longStoryTitle,
              author: author,
              createdAt: createdAt,
            ),
          ),
        ),
      );

      expect(find.textContaining(longStoryTitle), findsOneWidget);
      expect(
        tester.getSize(find.text(longStoryTitle)).height,
        lessThan(100),
      );
    });
  });
}
