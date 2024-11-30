class Article {
  final String author;
  final DateTime createdAt;
  final String storyTitle;

  Article({
    required this.author,
    required this.createdAt,
    required this.storyTitle,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"],
        createdAt: DateTime.parse(json["created_at"]),
        storyTitle: json["story_title"],
      );
}
