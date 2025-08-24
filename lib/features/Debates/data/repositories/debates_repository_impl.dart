import 'package:dartz/dartz.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/network/network_info.dart';
import 'package:poi/features/Debates/data/datasources/debates_remote_data_source.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class DebatesRepositoryImpl implements DebatesRepository {
  final DebatesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DebatesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DebatesModel>> getAnnouncedDebates({required int currentPage}) async {
    try {
      final remotedebates = await remoteDataSource.getAnnouncedDebates(currentPage: currentPage);
      return Right(remotedebates);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
