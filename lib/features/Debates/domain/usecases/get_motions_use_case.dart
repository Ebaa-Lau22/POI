import 'package:dartz/dartz.dart';
import 'package:poi/core/app_models/base_model.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/new_motion_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class GetMotionsUseCase {
  final DebatesRepository repository;

  GetMotionsUseCase({required this.repository});

  Future<Either<Failure, BaseResponse<List<NewMotionModel>>>> call() async {
    return await repository.getMotions();
  }
}
