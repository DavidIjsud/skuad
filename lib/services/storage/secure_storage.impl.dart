import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skuadchallengue/services/storage/secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl() : _secureStorage = const FlutterSecureStorage();
  final FlutterSecureStorage _secureStorage;
}
