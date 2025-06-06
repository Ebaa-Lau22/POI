import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poi/core/constants/appLink.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/features/Authentication/data/models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> login(LoginModel loginModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> login(LoginModel loginModel) async {
    final body = {"email": loginModel.email, "password": loginModel.password};
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
