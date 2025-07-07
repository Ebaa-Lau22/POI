import 'package:poi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/presentation/pages/Reset_password_page.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(LoginEntity loginModel);
  Future<Either<Failure, Unit>> sendCode(SendCodeEntity sendCodeModel);
  Future<Either<Failure, Unit>> verifyCode(
    VerificationCodeEntity verifyCodeModel,
  );
  Future<Either<Failure, Unit>> resetPassword(
    ResetPasswordEntity resetPassModel,
  );
}
