import 'package:http/http.dart';
import 'package:skuadchallengue/services/network/network_client.dart';

class FakeNetworkClient implements NetworkClient {
  late final Response response;

  void addMockResponse(Response response) {
    this.response = response;
  }

  @override
  Future<Response> get(Uri uri, {Map<String, String>? headersParam}) async {
    Future.delayed(const Duration(seconds: 5));
    return response;
  }
}
