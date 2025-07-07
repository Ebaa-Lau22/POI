import 'package:dartz/dartz.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, Unit>> call({required LoginEntity loginEntity}) async {
    return await authRepository.login(loginEntity);
  }
}
