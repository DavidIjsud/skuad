import 'package:dartz/dartz.dart';
import 'package:skuadchallengue/modules/home/data/models/article.dart';

abstract class HomeRepository {
  Future<Either<Fail, List<Article>>> getArticles();
}
