// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:poi/features/Authentication/data/models/login_response_model.dart';

import '../../domain/entities/auth.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {
  LoginResponseModel response;
  AuthLoginSuccessState({required this.response});
}

class AuthLoginErrorState extends AuthStates {
  final String errorMessage;
  AuthLoginErrorState({required this.errorMessage});
}

class AuthSendCodeSuccessState extends AuthStates {
  final String successMessage;
  AuthSendCodeSuccessState({required this.successMessage});
}

class AuthSendCodeErrorState extends AuthStates {
  final String errorMessage;
  AuthSendCodeErrorState({required this.errorMessage});
}

class AuthVerifyCodeSuccessState extends AuthStates {
  final String successMessage;
  AuthVerifyCodeSuccessState({required this.successMessage});
}

class AuthVerifyCodeErrorState extends AuthStates {
  final String errorMessage;
  AuthVerifyCodeErrorState({required this.errorMessage});
}

class AuthResetPasswordSuccessState extends AuthStates {
  final String successMessage;
  AuthResetPasswordSuccessState({required this.successMessage});
}

class AuthResetPasswordErrorState extends AuthStates {
  final String errorMessage;
  AuthResetPasswordErrorState({required this.errorMessage});
}
