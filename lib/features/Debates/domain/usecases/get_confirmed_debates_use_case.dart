import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class GetFinishedDebatesUseCase {
  final DebatesRepository repository;

  GetFinishedDebatesUseCase({required this.repository});

  Future<Either<Failure, DebateModel>> call() async {
    return repository.getFinishedDebates();
  }
}
