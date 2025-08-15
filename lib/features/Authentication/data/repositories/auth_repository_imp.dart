import 'package:dartz/dartz.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/network/network_info.dart';
import 'package:poi/features/Authentication/data/datasources/auth_remote_data_source.dart';
import 'package:poi/features/Authentication/data/models/auth_model.dart';
import 'package:poi/features/Authentication/data/models/login_response_model.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LoginResponseModel>> login(LoginEntity loginEntity) async {
    final LoginModel loginModel = LoginModel(
      email: loginEntity.email,
      password: loginEntity.password,
    );
    return await _getMessage2(() {
    return remoteDataSource.login(loginModel); // Future<LoginResponseModel>
  });
  }

  @override
  Future<Either<Failure, Unit>> sendCode(SendCodeEntity sendCodeEntity) async {
    final SendCodeModel sendCodeModel = SendCodeModel(
      email: sendCodeEntity.email,
    );
    return await _getMessage(() {
      return remoteDataSource.sendCode(sendCodeModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> verifyCode(
    VerificationCodeEntity verifyCodeEntity,
  ) async {
    final VerifyCodeModel verifyCodeModel = VerifyCodeModel(
      code: verifyCodeEntity.code,
    );
    return await _getMessage(() {
      return remoteDataSource.verifyCode(verifyCodeModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
    ResetPasswordEntity resetPassEntity,
  ) async {
    final ResetPasswordModel resetPasswordModel = ResetPasswordModel(
      newPass: resetPassEntity.newPass,
      confirmPass: resetPassEntity.confirmPass,
    );
    return await _getMessage(() {
      return remoteDataSource.resetPassword(resetPasswordModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
    Future<Unit> Function() action,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await action();
        return const Right(unit);
      } on WrongDataException {
        return Left(WrongDataFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
Future<Either<Failure, T>> _getMessage2<T>(
  Future<T> Function() action,
) async {
  if (await networkInfo.isConnected) {
    try {
      final result = await action();
      return Right(result);
    } on WrongDataException {
      return Left(WrongDataFailure());
    } on ServerException {
      return Left(ServerFailure());
    }catch (_) {
      return Left(ServerFailure()); 
    }
  } else {
    return Left(OfflineFailure());
  }
}

}
