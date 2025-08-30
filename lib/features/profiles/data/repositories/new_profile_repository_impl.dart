import 'package:dartz/dartz.dart';
import 'package:poi/core/app_models/new_profile_model.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/profiles/data/datasources/new_profile_remote_data_source.dart';
import 'package:poi/features/profiles/domain/repositories/new_profile_respository.dart';

class NewProfileRepositoryImpl implements NewProfileRespository {
  final NewProfileRemoteDataSource _remote;

  NewProfileRepositoryImpl({required NewProfileRemoteDataSource remote})
    : _remote = remote;

  @override
  Future<Either<Failure, NewProfileModel>> getProfile() async {
    try {
      final response = await _remote.getProfile();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
