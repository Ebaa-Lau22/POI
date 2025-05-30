import 'package:dartz/dartz.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/repositories/auth_repository.dart';
import '../../../../core/error/failures.dart';

class LoginUseCase{
  final AuthRepository auth_repository;

  LoginUseCase({required this.auth_repository});

  Future<Either<Failure, Unit>> call({
    required LoginEntity login_entity
  }) async{
    return await auth_repository.login(login_entity);
  }
}