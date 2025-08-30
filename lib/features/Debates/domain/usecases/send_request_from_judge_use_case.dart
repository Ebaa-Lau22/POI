import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/dto/send_request_from_judge_dto.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class SendRequestFromJudgeUseCase {
  final DebatesRepository repository;

  SendRequestFromJudgeUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({
    required SendRequestFromJudgeDto sendRequestFromJudge,
  }) async {
    return await repository.sendRequestFromJudge(sendRequestFromJudge);
  }
}
