// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../domain/entities/auth.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {
  String successMessage;
  AuthLoginSuccessState({
    required this.successMessage,
  });
}

class AuthLoginErrorState extends AuthStates {
  String errorMessage;
  AuthLoginErrorState({
    required this.errorMessage,
  });
}
