import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skuadchallengue/app/models/request_article_request.dart';
import 'package:skuadchallengue/modules/home/data/models/article.dart';
import 'package:skuadchallengue/modules/home/data/repositories/home_repository.dart';

import '../../../../core/endpoints.dart';
import '../../../../services/network/network_client.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required NetworkClient networkClient,
    required Endpoints endpoints,
  })  : _networkClient = networkClient,
        _endpoints = endpoints;

  final NetworkClient _networkClient;
  final Endpoints _endpoints;

  @override
  Future<Either<Fail, List<Article>>> getArticles() async {
    final request = GetArticlesRequest(
      url: _endpoints.articlesEndpoint,
    );

    try {
      final response = await _networkClient.get(
        Uri.parse(request.url),
        headersParam: request.headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final articles = List<Article>.from(
          body['hits'].map(
            (article) => Article.fromJson(article),
          ),
        );
        return right(articles);
      } else {
        return left(Fail(response.body));
      }
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
