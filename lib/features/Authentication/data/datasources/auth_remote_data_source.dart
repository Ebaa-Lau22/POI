import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poi/core/constants/appLink.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/storage/preferences_database.dart';
import 'package:poi/features/Authentication/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> login(LoginModel loginModel);
  Future<Unit> sendCode(SendCodeModel sendCodeModel);
  Future<Unit> verifyCode(VerifyCodeModel verifyCodeModel);
  Future<Unit> resetPassword(ResetPasswordModel resetPasswordModel);
}

String baseUrl = "http://192.168.1.33:8000/api";

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> login(LoginModel loginModel) async {
    final body = {"email": loginModel.email, "password": loginModel.password};

    final response = await client.post(
      Uri.parse("${baseUrl}/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');
    if (response.statusCode == 200) {
      // final token = jsonDecode(response.body)['data']['token'];
      // final guard = jsonDecode(response.body)['data']['guard'];

      // print('Token: $token, Guard: $guard');

      // final prefs = PreferencesDatabase();
      // await prefs.setEncryptedValue("Token", token);
      // await prefs.setEncryptedValue("Guard", guard);
      return Future.value(unit);
    } else if (response.statusCode == 401) {
      print("THROWING WrongDataException!");
      throw WrongDataException();
    } else {
      throw ServerException();
    }
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
}
