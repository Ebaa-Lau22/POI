import 'package:poi/features/Authentication/domain/entities/auth.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.email, required super.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}

////////////////////////////////////////////////////////////////////////////////////

class SendCodeModel extends SendCodeEntity {
  const SendCodeModel({required super.email});

  factory SendCodeModel.fromJson(Map<String, dynamic> json) {
    return SendCodeModel(email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}

////////////////////////////////////////////////////////////////////////////////////


class VerifyCodeModel extends VerificationCodeEntity {
  const VerifyCodeModel({required super.code});

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) {
    return VerifyCodeModel(code: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code};
  }
}

////////////////////////////////////////////////////////////////////////////////////


class ResetPasswordModel extends ResetPasswordEntity {
  const ResetPasswordModel({
    required super.newPass,
    required super.confirmPass,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      newPass: json['newPass'],
      confirmPass: json['confirmPass'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'newPass': newPass, 'confirmPass': confirmPass};
  }
}

////////////////////////////////////////////////////////////////////////////////////

