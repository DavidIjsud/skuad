import 'dart:io';

import 'package:http/src/client.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;
import 'network_client.dart';

class NetworkClientImpl implements NetworkClient {
  Client get client => http.Client();

  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.acceptHeader: ContentType.json.toString(),
      };

  @override
  Future<Response> get(Uri uri, {Map<String, String>? headersParam}) async {
    final requestHeaders = headers;
    if (headersParam?.isNotEmpty == true) {
      requestHeaders.addAll(headers ?? {});
    }

    final response = await client.get(
      uri,
      headers: requestHeaders,
    );

    return response;
  }
}
