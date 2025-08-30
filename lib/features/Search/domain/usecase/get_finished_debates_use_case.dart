import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Search/domain/repo/search_repo.dart';

class GetFinishedDebatesUseCase {
  final SearchRepo searchRepo;

  GetFinishedDebatesUseCase({required this.searchRepo});

  Future<Either<Failure, DebateModel>> call() async {
    return searchRepo.getFinishedDebates();
  }
}
