import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiRepository {
  final _baseUrl = "https://20c07f40-5f5b-4e8e-a378-9eddeeaeb5b5.mock.pstmn.io";
  final Dio _dio;

  ApiRepository(this._dio);

  Future<void> test({required String token}) async {
    const api = '/test';
    final url = '$_baseUrl$api';

    try {
      final response = await _dio.get(
        url,
        queryParameters: {
          "token": token,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      debugPrint("response.data: ${response.data}");
      return;
    } catch (e) {
      debugPrint("API Request Error Type: ${e.toString()}");
      rethrow;
    }
  }

  Future<Response> refreshToken({required String token, required String refreshToken}) async {
    const api = '/refreshToken';
    final url = '$_baseUrl$api';

    try {
      final response = await _dio.post(
        url,
        data: {
          "token": token,
          "refresh_token": refreshToken,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      return response;
    } catch (e) {
      debugPrint("API Request Error Type: ${e.toString()}");
      rethrow;
    }
  }
}
