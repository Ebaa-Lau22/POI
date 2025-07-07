import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/repositories/auth_repository.dart';

class SendCodeUseCase {
  final AuthRepository authRepository;

  SendCodeUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call({
    required SendCodeEntity sendCodeEntity,
  }) async {
    return await authRepository.sendCode(sendCodeEntity);
  }
}
