import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:skuadchallengue/modules/home/data/repositories/home_repository.dart';
import 'package:skuadchallengue/modules/home/presentation/bloc/home_bloc.dart';
import 'package:skuadchallengue/modules/home/presentation/bloc/home_events.dart';
import 'package:skuadchallengue/modules/home/presentation/bloc/home_state.dart';
import 'package:skuadchallengue/services/network/network_client.dart';

import 'mocks/get_articles_usecase_mock.dart';
import 'mocks/home_repository_mock.dart';
import 'mocks/network_repository_mock.dart';

void main() {
  group('Testing home bloc', () {
    late HomeRepository homeRepositoryMock;
    late NetworkClient networkClientMock;
    late FakeGetArticlesUseCaseMock getArticlesUseCaseMock;
    late HomeBloc homeBloc;

    setUp(() {
      networkClientMock = FakeNetworkClient();
      homeRepositoryMock = FakeHomeRepository(
        networkClient: networkClientMock,
      );
      getArticlesUseCaseMock = FakeGetArticlesUseCaseMock(
        homeRepository: homeRepositoryMock as FakeHomeRepository,
      );
      homeBloc = HomeBloc(getArticlesUseCase: getArticlesUseCaseMock);
      final mockResponse = {'hits': []};
      (networkClientMock as FakeNetworkClient).addMockResponse(
        Response(
          json.encode(mockResponse),
          200,
        ),
      );
    });

    test('Testing initial state', () {
      expect(homeBloc.state, const HomeState());
    });

    blocTest(
      'emits isLoadingArticles: true when GetArticlesEvent is added',
      build: () => homeBloc,
      act: (bloc) => bloc.add(GetArticlesEvent()),
      expect: () => [
        const HomeState(isLoadingArticles: true),
        const HomeState(
          isLoadingArticles: false,
          isSuccess: true,
          articles: [], // Expected articles
        ),
      ],
    );
  });
}
