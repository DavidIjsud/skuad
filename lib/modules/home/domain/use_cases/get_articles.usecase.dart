import '../../data/models/article.dart';

abstract class GetArticlesUseCase {
  Future<List<Article>> getArticles();
  List<Article> sortArticlesByCreatedAtDate(List<Article> articles);
}
