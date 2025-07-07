import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/repositories/auth_repository.dart';

class VerifyCodeUseCase {
  final AuthRepository authRepository;

  VerifyCodeUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call({
    required VerificationCodeEntity verifyCodeEntity,
  }) async {
    return await authRepository.verifyCode(verifyCodeEntity);
  }
}
