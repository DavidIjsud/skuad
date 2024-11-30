import 'dart:io';
import 'package:http/http.dart' as http;

abstract class NetworkClient {
  final _headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.toString(),
    HttpHeaders.acceptHeader: ContentType.json.toString(),
  };

  final _client = http.Client();

  Future<http.Response> get(
    Uri uri, {
    Map<String, String>? headers,
  });
}
