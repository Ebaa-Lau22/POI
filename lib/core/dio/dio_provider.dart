import 'package:dio/dio.dart';
import 'package:poi/core/logger/dio_logger.dart';

class DioProvider {
  static provide({required String baseUrl, List<Interceptor>? interceptors}) {
    final Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if (interceptors != null) {
      for (Interceptor interceptor in interceptors) {
        dio.interceptors.add(interceptor);
      }
    }
    dio.interceptors.add(dioLogger);
    return dio;
  }
}
