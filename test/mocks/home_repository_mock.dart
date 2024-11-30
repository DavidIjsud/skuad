import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:skuadchallengue/modules/home/data/models/article.dart';
import 'package:skuadchallengue/modules/home/data/repositories/home_repository.dart';
import 'package:skuadchallengue/services/network/network_client.dart';

class FakeHomeRepository implements HomeRepository {
  FakeHomeRepository({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  final NetworkClient _networkClient;

  @override
  Future<Either<Fail, List<Article>>> getArticles() async {
    final response = await _networkClient.get(
      Uri.parse('https://hn.algolia.com/api/v1/search_by_date?query=mobile'),
    );

    if (response.statusCode == 200) {
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
  }
}
