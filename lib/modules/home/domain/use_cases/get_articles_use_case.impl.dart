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
    return await result.fold((l) async {
      return sortArticlesByCreatedAtDate(
        await _secureStorage.getListOfArticlesOnStorage(),
      );
    }, (articles) async {
      await _secureStorage.saveListOfArticlesOnStorage(articles);
      return sortArticlesByCreatedAtDate(articles);
    });
  }

  @override
  List<Article> sortArticlesByCreatedAtDate(List<Article> articles) {
    articles.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return articles;
  }
}
