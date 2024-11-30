import 'package:equatable/equatable.dart';

import '../../data/models/article.dart';

class HomeState extends Equatable {
  const HomeState({
    this.isLoadingArticles,
    this.hasError,
    this.isSuccess,
    this.articles,
  });

  final bool? isLoadingArticles, hasError, isSuccess;
  final List<Article>? articles;

  @override
  List<Object?> get props => [isLoadingArticles, hasError, isSuccess, articles];

  HomeState copyWith({
    bool? isLoadingArticles,
    bool? hasError,
    bool? isSuccess,
    List<Article>? articles,
  }) {
    return HomeState(
      isLoadingArticles: isLoadingArticles ?? this.isLoadingArticles,
      hasError: hasError ?? this.hasError,
      isSuccess: isSuccess ?? this.isSuccess,
      articles: articles ?? this.articles,
    );
  }
}
