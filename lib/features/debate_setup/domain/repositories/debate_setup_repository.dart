import 'package:dartz/dartz.dart';
import 'package:poi/core/app_entities/motion_entity.dart';
import '../../../../core/error/failures.dart';

abstract class DebateSetupRepository{
  Future<Either<Failure, List<MotionEntity>>> getAllMotions();
  Future<Either<Failure, Unit>> addMotion(MotionEntity motion);
  Future<Either<Failure, List<String>>> getAllTopics();
}