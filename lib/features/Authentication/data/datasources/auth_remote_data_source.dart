import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poi/core/constants/appLink.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/features/Authentication/data/models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> Login(LoginModel login_model);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> Login(LoginModel login_model) async {
    final body = {"email": login_model.email, "password": login_model.password};
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
