import 'package:dartz/dartz.dart';
import 'package:skuadchallengue/modules/home/data/models/article.dart';
import 'package:skuadchallengue/modules/home/domain/use_cases/get_articles.usecase.dart';

import 'home_repository_mock.dart';

class FakeGetArticlesUseCaseMock implements GetArticlesUseCase {
  FakeGetArticlesUseCaseMock({
    required FakeHomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  final FakeHomeRepository _homeRepository;

  @override
  Future<List<Article>> getArticles() async {
    final result = await _homeRepository.getArticles();
    return await result.fold((l) async {
      return [];
    }, (articles) async {
      return sortArticlesByCreatedAtDate(articles);
    });
  }

  @override
  List<Article> sortArticlesByCreatedAtDate(List<Article> articles) {
    articles.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return articles;
  }
}
