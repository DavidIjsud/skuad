import 'package:skuadchallengue/modules/home/data/models/article.dart';

abstract class SecureStorage {
  Future<void> saveListOfArticlesOnStorage(List<Article> articles);

  Future<List<Article>> getListOfArticlesOnStorage();
}
