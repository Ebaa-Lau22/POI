import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Search/data/datasource/search_remote_data_source.dart';
import 'package:poi/features/Search/data/models/user_model.dart';
import 'package:poi/features/Search/domain/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepoImpl({required this.searchRemoteDataSource});

  @override
  Future<Either<Failure, DebatesModel>> getFinishedDebates() async {
    try {
      final result = await searchRemoteDataSource.getFinishedDebates();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUsers() async {
    try {
      final result = await searchRemoteDataSource.getUsers();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
