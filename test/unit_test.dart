import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:skuadchallengue/core/endpoints.dart';
import 'package:skuadchallengue/modules/home/data/models/article.dart';
import 'package:skuadchallengue/modules/home/data/repositories/home_repository.dart';
import 'package:skuadchallengue/services/network/network_client.dart';

import 'mocks/get_articles_usecase_mock.dart';
import 'mocks/home_repository_mock.dart';
import 'mocks/network_repository_mock.dart';

void main() {
  late HomeRepository homeRepositoryMock;
  late NetworkClient networkClientMock;
  late FakeGetArticlesUseCaseMock getArticlesUseCaseMock;
  late Endpoints endpointsMock;

  setUp(() {
    networkClientMock = FakeNetworkClient();
    endpointsMock = Endpoints(
        articlesEndpoint:
            'https://hn.algolia.com/api/v1/search_by_date?query=mobile');
    homeRepositoryMock = FakeHomeRepository(
      networkClient: networkClientMock,
    );
    getArticlesUseCaseMock = FakeGetArticlesUseCaseMock(
      homeRepository: homeRepositoryMock as FakeHomeRepository,
    );
  });

  group('getArticles', () {
    test('check if articles are well sorted by date', () async {
      final result = getArticlesUseCaseMock.sortArticlesByCreatedAtDate([
        Article(
            author: 'nunez',
            createdAt: DateTime(2024, 11, 29, 18, 19, 06),
            storyTitle:
                'Tesla is looking to hire a team to remotely control its self-driving robotaxis'),
        Article(
            author: 'er_Einzige',
            createdAt: DateTime(2024, 11, 30, 18, 03, 42),
            storyTitle:
                'The Surprisingly Sunny Origins of the Frankfurt School'),
        Article(
          author: 'David',
          createdAt: DateTime(2024, 11, 28, 18, 03, 42),
          storyTitle: 'The Surprisingly Sunny Origins of the Frankfurt School',
        ),
      ]);

      expect(result.length, 3);
      expect(result.first.author, 'er_Einzige');
      expect(result.first.createdAt, DateTime(2024, 11, 30, 18, 03, 42));
    });

    test('should return a list of articles', () async {
      final mockResponse = {
        'hits': [
          {
            'author': 'nunez',
            'created_at': '2024-11-30T18:19:06Z',
            'story_title':
                'Tesla is looking to hire a team to remotely control its self-driving robotaxis'
          },
          {
            'author': 'er_Einzige',
            'created_at': '024-11-30T18:03:42Z',
            'story_title':
                'The Surprisingly Sunny Origins of the Frankfurt School'
          }
        ]
      };
      (networkClientMock as FakeNetworkClient).addMockResponse(
        Response(
          json.encode(mockResponse),
          200,
        ),
      );
      final result = await homeRepositoryMock.getArticles();
      expect(result.isRight(), true);
      result.fold(
        (fail) => fail,
        (articles) {
          expect(articles, isNotNull);
          expect(articles.length, 2);
          expect(articles.first.author, 'nunez');
        },
      );
    });

    test('should return a fail with a response body error', () async {
      (networkClientMock as FakeNetworkClient).addMockResponse(
        Response(
          'internal server error',
          500,
        ),
      );
      final result = await homeRepositoryMock.getArticles();
      expect(result.isRight(), false);
      result.fold(
        (fail) {
          expect(fail.failure, 'internal server error');
        },
        (articles) {
          expect(articles, isNotNull);
          expect(articles.length, 2);
          expect(articles.first.author, 'nunez');
        },
      );
    });
  });
}
