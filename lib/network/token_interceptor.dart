import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:practice_flutter/network/api_repository.dart';
import 'package:practice_flutter/network/storage_repository.dart';
import 'package:practice_flutter/router_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TokenInterceptor extends InterceptorsWrapper {
  TokenInterceptor({
    required this.routerProvider,
    required this.apiRepository,
    required this.storageRepository,
  });

  final RouterProvider routerProvider;
  final ApiRepository apiRepository;
  final StorageRepository storageRepository;

  /// DioException 발생 시 실행됨
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 인증 오류가 발생했을 경우: AccessToken의 만료
    if (err.response?.statusCode == 401) {
      // 기기에 저장된 AccessToken과 RefreshToken 로드
      final token = await storageRepository.readToken() ?? "";
      final refreshToken = await storageRepository.readRefreshToken() ?? "";

      // 토큰 갱신 요청을 담당할 dio 객체 구현 후 그에 따른 interceptor 정의
      var refreshDio = Dio();
      refreshDio.interceptors.clear();

      /// Dio Log Interceptor
      /// 디버그 모드에서만 Dio 인스턴스의 모든 로그를 출력
      if (kDebugMode) {
        refreshDio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          compact: true,
        ));
      }

      refreshDio.interceptors.add(InterceptorsWrapper(onError: (error, handler) async {
        // 다시 인증 오류가 발생했을 경우: RefreshToken의 만료
        if (error.response?.statusCode == 401) {
          // 기기의 자동 로그인 정보 삭제
          await storageRepository.removeAllTokens();
          routerProvider.logout();
        }
        return super.onError(error, handler);
      }));

      // ToDo: 원래는 refreshDio 헤더에 현재 가지고 있는 만료된 데이터 추가 필요

      final apiRepository = ApiRepository(refreshDio);
      // 토큰 갱신 API 요청
      final refreshResponse = await apiRepository.refreshToken(
        token: token,
        refreshToken: refreshToken,
      );
      final newToken = refreshResponse.data["token"];
      await storageRepository.saveToken(newToken);

      // ToDo: 원래는 error.requestOption 헤더에 액세스 토큰 갱신 필요

      // 수행하지 못했던 API 요청 복사본 생성
      final clonedRequest = await Dio().request(
        err.requestOptions.path,
        options: Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        ),
        data: err.requestOptions.data,
        queryParameters: {
          "token": newToken,
        },
      );

      // API 복사본으로 재요청
      return handler.resolve(clonedRequest);
    }
    return super.onError(err, handler);
  }
}
