import 'package:dio/dio.dart';

abstract class ApiServices {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams});

  Future post(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    FormData? formData,
  });
  Future patch(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    FormData? formData,
  });

  Future postFiles(
    String path, {
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
    Map<String, dynamic>? body,
    FormData? formData,
    String? key,
    Function(int count, int total)? onUploadingProgressChanged,
  });
  Future postList(
    String path, {
    Map<String, String>? queryParams,
    List<dynamic>? body,
    FormData? formData,
  });
  Future put(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    FormData? formData,
  });
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });
  Future<void> downloadFile(
    String path,
    String savePath, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    String? key,
    FormData? formData,
    CancelToken? cancelToken,
    Function(int count, int total)? onDownloadingProgressChanged,
  });
}
