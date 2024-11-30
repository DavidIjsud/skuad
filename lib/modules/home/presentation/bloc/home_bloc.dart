//create the home bloc class

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skuadchallengue/modules/home/domain/use_cases/get_articles.usecase.dart';

import 'home_events.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc({required GetArticlesUseCase getArticlesUseCase})
      : _getArticlesUseCase = getArticlesUseCase,
        super(const HomeState()) {
    on<GetArticlesEvent>(_getArticlesEvent);
  }

  final GetArticlesUseCase _getArticlesUseCase;

  Future<void> _getArticlesEvent(
    GetArticlesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState(isLoadingArticles: true));
    final articles = await _getArticlesUseCase.getArticles();
    emit(state.copyWith(
        articles: articles, isSuccess: true, isLoadingArticles: false));
  }
}
