import 'package:poi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(LoginEntity login_entity);
}