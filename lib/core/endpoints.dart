class Endpoints {
  Endpoints({
    required this.loginEndPoint,
    required this.getClientsEndPoint,
    required this.addClientEndPoint,
    required this.editClient,
    required this.removeClientEndPoint,
  });

  final String loginEndPoint;
  final String getClientsEndPoint;
  final String addClientEndPoint;
  final String editClient;
  final String removeClientEndPoint;

  factory Endpoints.fromJson(Map<String, dynamic> json) {
    return Endpoints(
      loginEndPoint: json[_AttributesKeys.loginEndPoint],
      getClientsEndPoint: json[_AttributesKeys.getClientsEndPoint],
      addClientEndPoint: json[_AttributesKeys.addClientEndPoint],
      editClient: json[_AttributesKeys.editClientEndPoint],
      removeClientEndPoint: json[_AttributesKeys.removeClientEndPoint],
    );
  }
}

abstract class _AttributesKeys {
  static const String loginEndPoint = 'loginEndPoint';
  static const String getClientsEndPoint = 'getClientsEndPoint';
  static const String addClientEndPoint = 'addClientEndPoint';
  static const String editClientEndPoint = 'editClientEndPoint';
  static const String removeClientEndPoint = 'removeClientEndPoint';
}
