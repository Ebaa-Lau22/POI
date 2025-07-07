import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String email;
  final String password;

  const LoginEntity({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SendCodeEntity extends Equatable {
  final String email;

  const SendCodeEntity({required this.email});
  @override
  List<Object?> get props => [email];
}

class VerificationCodeEntity extends Equatable {
  final String code;

  const VerificationCodeEntity({required this.code});
  @override
  List<Object?> get props => [code];
}

class ResetPasswordEntity extends Equatable {
  final String newPass;
  final String confirmPass;

  const ResetPasswordEntity({required this.newPass, required this.confirmPass});
  @override
  List<Object?> get props => [newPass, confirmPass];
}
