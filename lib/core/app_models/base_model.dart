class BaseResponse<T> {
  final bool success;
  final String message;
  final T data;
  final dynamic errors;

  BaseResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> dataJson) fromJsonT,
  ) {
    return BaseResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: fromJsonT(json),
      errors: json['errors'],
    );
  }
}
