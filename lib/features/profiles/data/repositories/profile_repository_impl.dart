import 'package:dartz/dartz.dart';
import 'package:poi/core/app_entities/profile_entity.dart';
import 'package:poi/core/app_models/profile_model.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/network/network_info.dart';
import 'package:poi/features/profiles/data/datasources/profile_remote_data_source.dart';
import 'package:poi/features/profiles/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final remoteProfile = await remoteDataSource.getProfile();
      return Right(remoteProfile );
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
