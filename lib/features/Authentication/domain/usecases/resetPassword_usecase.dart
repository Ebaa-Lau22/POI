import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call({
    required ResetPasswordEntity resetPassEntity,
  }) async {
    return await authRepository.resetPassword(resetPassEntity);
  }
}
