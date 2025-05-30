import 'package:dartz/dartz.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/network/network_info.dart';
import 'package:poi/features/Authentication/data/datasources/auth_remote_data_source.dart';
import 'package:poi/features/Authentication/data/models/login_model.dart';
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
  Future<Either<Failure, Unit>> login(LoginEntity login_entity) async {
    final LoginModel login_model = LoginModel(email: login_entity.email, password: login_entity.password);
    return await _getMessage(() {
      return remoteDataSource.Login(login_model);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }

  }
}
