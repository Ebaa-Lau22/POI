import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/add_feedback_response_model.dart';
import 'package:poi/features/Debates/data/models/dto/add_feedback_dto.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class AddFeedbackUseCase {
  final DebatesRepository repository;

  AddFeedbackUseCase({required this.repository});

  Future<Either<Failure, AddFeedbackResponseModel>> call({
    required AddFeedbackDto feedback,
  }) async {
    return await repository.addFeedback(feedback);
  }
}
