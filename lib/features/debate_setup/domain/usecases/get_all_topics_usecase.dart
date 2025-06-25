import 'package:dartz/dartz.dart';
import 'package:poi/features/debate_setup/domain/repositories/debate_setup_repository.dart';
import '../../../../core/app_entities/motion_entity.dart';
import '../../../../core/error/failures.dart';

class GetAllTopicsUsecase{
  final DebateSetupRepository debateRepo;

  GetAllTopicsUsecase({required this.debateRepo});

  Future<Either<Failure, List<String>>> call() async{
    return await debateRepo.getAllTopics();
  }
}