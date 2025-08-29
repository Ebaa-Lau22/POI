import 'package:dio/dio.dart';
import 'package:poi/core/storage/preferences_database.dart';

class CoreTokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = PreferencesDatabase();

    final savedToken = await prefs.getToken();

    if (savedToken != null && savedToken.isNotEmpty) {
      options.headers.addAll({'Authorization': 'Bearer $savedToken'});
    }
    handler.next(options);
  }
}
