import 'package:dartz/dartz.dart';
import 'package:poi/core/app_entities/motion_entity.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/network/network_info.dart';
import 'package:poi/features/debate_setup/domain/repositories/debate_setup_repository.dart';
import '../../../../core/app_models/motion_model.dart';
import '../../../../core/error/exceptions.dart';
import '../datasources/debate_setup_remote_datasource.dart';

class DebateSetupRepositoryImpl extends DebateSetupRepository{
  final NetworkInfo networkInfo;
  final DebateSetupRemoteDatasource remoteDatasource;

  DebateSetupRepositoryImpl({required this.networkInfo, required this.remoteDatasource});

  @override
  Future<Either<Failure, Unit>> addMotion(MotionEntity motion) async{
    MotionModel motionModel = MotionModel(title: motion.title, topics: motion.topics);
    if (await networkInfo.isConnected) {
      try {
        remoteDatasource.addMotion(motionModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<MotionEntity>>> getAllMotions() async{
    try {
      final remoteMotions = await remoteDatasource.getAllMotions();
      return Right(remoteMotions);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllTopics() async{
    try {
      final remoteTopics = await remoteDatasource.getAllTopics();
      return Right(remoteTopics);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}