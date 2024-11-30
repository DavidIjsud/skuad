import 'package:http/http.dart' as http;

abstract class NetworkClient {
  Future<http.Response> get(
    Uri uri, {
    Map<String, String>? headersParam,
  });
}
