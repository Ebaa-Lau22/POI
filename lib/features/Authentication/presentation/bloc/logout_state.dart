// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class LogoutState {}

class LogoutInitialState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutSuccessState extends LogoutState {}

class LogoutErrorState extends LogoutState {
  final String errorMessage;
  LogoutErrorState({required this.errorMessage});
}
