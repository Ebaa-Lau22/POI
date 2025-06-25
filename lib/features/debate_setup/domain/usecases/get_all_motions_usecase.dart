import 'package:dartz/dartz.dart';
import 'package:poi/features/debate_setup/domain/repositories/debate_setup_repository.dart';
import '../../../../core/app_entities/motion_entity.dart';
import '../../../../core/error/failures.dart';

class GetAllMotionsUsecase{
  final DebateSetupRepository debateRepo;

  GetAllMotionsUsecase({required this.debateRepo});

  Future<Either<Failure, List<MotionEntity>>> call() async{
    return await debateRepo.getAllMotions();
  }
}