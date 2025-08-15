import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
    LoginResponseModel({
        required this.success,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool success;
    final String message;
    final Data? data;
    final dynamic errors;

    factory LoginResponseModel.fromJson(Map<String, dynamic> json){ 
        return LoginResponseModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            errors: json["errors"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "errors": errors,
    };

    @override
    List<Object?> get props => [
    success, message, data, errors, ];
}

class Data extends Equatable {
    Data({
        required this.token,
        required this.guard,
    });

    final String token;
    final String guard;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            token: json["token"] ?? "",
            guard: json["guard"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "token": token,
        "guard": guard,
    };

    @override
    List<Object?> get props => [
    token, guard, ];
}
