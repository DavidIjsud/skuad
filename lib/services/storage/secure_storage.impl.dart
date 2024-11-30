import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skuadchallengue/modules/home/data/models/article.dart';
import 'package:skuadchallengue/services/storage/secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl() : _secureStorage = const FlutterSecureStorage();
  final FlutterSecureStorage _secureStorage;

  @override
  Future<List<Article>> getListOfArticlesOnStorage() async {
    final articles = await _secureStorage.read(key: 'articles');
    if (articles != null) {
      return (jsonDecode(articles) as List)
          .map((article) => Article.fromJson(article as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveListOfArticlesOnStorage(List<Article> articles) async {
    await _secureStorage.write(key: 'articles', value: jsonEncode(articles));
  }
}
