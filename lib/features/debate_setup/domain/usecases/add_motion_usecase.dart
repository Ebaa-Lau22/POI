import 'package:dartz/dartz.dart';
import 'package:poi/features/debate_setup/domain/repositories/debate_setup_repository.dart';
import '../../../../core/app_entities/motion_entity.dart';
import '../../../../core/error/failures.dart';

class AddMotionUsecase{
  final DebateSetupRepository debateRepo;

  AddMotionUsecase({required this.debateRepo});

  Future<Either<Failure, Unit>> call({
    required MotionEntity motion,
}) async{
    return await debateRepo.addMotion(motion);
  }
}