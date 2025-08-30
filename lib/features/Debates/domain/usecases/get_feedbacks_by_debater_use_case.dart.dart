import 'package:poi/features/Debates/data/models/get_feedback_for_debater_response_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';
import 'package:poi/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetFeedbacksByDebaterUseCase {
  final DebatesRepository repository;
  GetFeedbacksByDebaterUseCase({required this.repository});
  Future<Either<Failure, GetFeedbackByDebaterResponseModel>> call() async {
    return await repository.getFeedbackByDebater();
  }
}
