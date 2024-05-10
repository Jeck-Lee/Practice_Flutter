import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storageKeyToken = 'ACCESS_TOKEN';
const _storageKeyRefreshToken = 'REFRESH_TOKEN';

class StorageRepository {
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: _storageKeyToken, value: token);
  }

  Future<String?> readToken() async {
    return await storage.read(key: _storageKeyToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await storage.write(key: _storageKeyRefreshToken, value: refreshToken);
  }

  Future<String?> readRefreshToken() async {
    return await storage.read(key: _storageKeyRefreshToken);
  }

  Future<void> removeAllTokens() async {
    await storage.write(key: _storageKeyToken, value: null);
    await storage.write(key: _storageKeyRefreshToken, value: null);
  }
}
