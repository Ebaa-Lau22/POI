import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/feedback_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class GetFeedbackUseCase {
  final DebatesRepository repository;

  GetFeedbackUseCase({required this.repository});

  Future<Either<Failure, FeedbackModel>> call(int debateId) async {
    return await repository.getFeedback(debateId);
  }
}
