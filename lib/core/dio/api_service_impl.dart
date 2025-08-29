import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api_service.dart';

class ApiServicesImp implements ApiServices {
  final Dio _dio;
  ApiServicesImp(this._dio);

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    bool? hasToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParams,
        data: body,
      );

      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParams,
    bool? hasToken,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    FormData? formData,
    bool? hasToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: queryParams,
        data: formData ?? body,
        onSendProgress: (count, total) {
          debugPrint("Uploading : ${count / total}%");
        },
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future patch(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    FormData? formData,
    bool? hasToken,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        queryParameters: queryParams,
        data: formData ?? body,
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future postFiles(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    String? key,
    FormData? formData,
    CancelToken? cancelToken,
    Function(int count, int total)? onUploadingProgressChanged,
  }) async {
    try {
      _dio.options.sendTimeout = Duration(days: 1);
      final response = await _dio.post(
        path,
        queryParameters: queryParams,
        cancelToken: cancelToken,
        data: formData ?? body,
        onSendProgress: onUploadingProgressChanged,
        onReceiveProgress: (sent, total) {
          if (total != -1) {
            var progress = (sent / total * 100).toStringAsFixed(0);
            if (kDebugMode) {
              debugPrint('Download progress: $progress%');
            }
          }
        },
      );
      _dio.options.sendTimeout = Duration(minutes: 1);

      return _handleResponseAsJson(response);
    } catch (error) {
      _dio.options.sendTimeout = Duration(minutes: 1);
      rethrow;
    }
  }

  dynamic _handleResponseAsJson(Response response) {
    return response.data;
  }

  @override
  Future postList(
    String path, {
    Map<String, String>? queryParams,
    List? body,
    FormData? formData,
    bool? hasToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: queryParams,
        data: formData ?? body,
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    FormData? formData,
    bool? hasToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: queryParams,
        data: formData ?? body,
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> downloadFile(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    String? key,
    FormData? formData,
    CancelToken? cancelToken,
    Function(int count, int total)? onDownloadingProgressChanged,
  }) async {
    try {
      await _dio.download(
        path,
        savePath,
        onReceiveProgress: onDownloadingProgressChanged,
        cancelToken: cancelToken,
        queryParameters: queryParams,
        data: formData ?? body,
        deleteOnError: true,
      );
    } catch (error) {
      rethrow;
    }
  }
}
