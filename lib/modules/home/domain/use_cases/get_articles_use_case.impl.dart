import 'package:skuadchallengue/services/storage/secure_storage.dart';

import '../../data/models/article.dart';
import '../../data/repositories/home_repository.dart';
import 'get_articles.usecase.dart';

class GetArticlesUseCaseImpl implements GetArticlesUseCase {
  GetArticlesUseCaseImpl(
      {required HomeRepository homeRepository,
      required SecureStorage secureStorage})
      : _homeRepository = homeRepository,
        _secureStorage = secureStorage;

  HomeRepository _homeRepository;
  SecureStorage _secureStorage;

  @override
  Future<List<Article>> getArticles() async {
    final result = await _homeRepository.getArticles();

    //TODO: when fail retrieve articles from secure storage
    return result.fold(
        (l) => [], (articles) => sortArticlesByCreatedAtDate(articles));
  }

  @override
  List<Article> sortArticlesByCreatedAtDate(List<Article> articles) {
    //TODO: implement sortArticlesByCreatedAtDate
    return articles;
  }
}
