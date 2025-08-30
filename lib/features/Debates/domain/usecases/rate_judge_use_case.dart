import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/dto/rate_judge_dto.dart';
import 'package:poi/features/Debates/data/models/rate_judge_response_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class RateJudgeUseCase {
  final DebatesRepository repository;

  RateJudgeUseCase({required this.repository});

  Future<Either<Failure, RateJudgeResponseModel>> call({required RateJudgeDto rateJudge}) async {
    return await repository.rateJudge(rateJudge);
  }
}
