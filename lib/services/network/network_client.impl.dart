import 'package:http/src/response.dart';

import 'network_client.dart';

class NetworkClientImpl implements NetworkClient {
  @override
  Future<Response> get(Uri uri, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }
}
