import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poi/core/constants/appLink.dart';
import 'package:poi/core/dio/api_service.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/features/Authentication/data/models/auth_model.dart';
import 'package:poi/features/Authentication/data/models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginModel loginModel);
  Future<Unit> sendCode(SendCodeModel sendCodeModel);
  Future<Unit> verifyCode(VerifyCodeModel verifyCodeModel);
  Future<Unit> resetPassword(ResetPasswordModel resetPasswordModel);
  Future<Unit> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices apiServices;
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.apiServices, required this.client});

  LoginResponseModel? loginResponse;

  @override
  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final body = {"email": loginModel.email, "password": loginModel.password};

    final response = await apiServices.post("login", body: body);
    return LoginResponseModel.fromJson(response);
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<Unit> sendCode(SendCodeModel sendCodeModel) async {
    final body = {"email": sendCodeModel.email};
    final response = await client.post(
      Uri.parse("${AppLink.postUrl}/"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> verifyCode(VerifyCodeModel verifyCodeModel) async {
    final body = {"code": verifyCodeModel.code};
    final response = await client.post(
      Uri.parse("${AppLink.postUrl}/"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> resetPassword(ResetPasswordModel resetPasswordModel) async {
    final body = {
      "newPass": resetPasswordModel.newPass,
      "confirmPass": resetPasswordModel.confirmPass,
    };
    final response = await client.post(
      Uri.parse("${AppLink.postUrl}/"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> logout() async {
    await apiServices.get("logout");
    return unit;
  }
}
