class Endpoints {
  Endpoints({
    required this.articlesEndpoint,
  });

  final String articlesEndpoint;

  factory Endpoints.fromJson(Map<String, dynamic> json) {
    return Endpoints(
      articlesEndpoint: json[_AttributesKeys.articlesEndpoint],
    );
  }
}

abstract class _AttributesKeys {
  static const String articlesEndpoint = 'articlesEndpoint';
}
