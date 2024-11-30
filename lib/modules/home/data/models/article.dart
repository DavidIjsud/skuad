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
        author: json["author"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"]) ?? DateTime.now()
            : DateTime.now(),
        storyTitle: json["story_title"] ?? "",
      );

  //to json method
  Map<String, dynamic> toJson() => {
        "author": author,
        "created_at": createdAt.toIso8601String(),
        "story_title": storyTitle,
      };
}
