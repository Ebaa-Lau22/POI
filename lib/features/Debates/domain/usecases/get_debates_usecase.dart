import 'package:dartz/dartz.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';
import '../../../../core/error/failures.dart';

class GetDebatesUseCase {
  final DebatesRepository repository;

  GetDebatesUseCase({required this.repository});

  Future<Either<Failure, DebateModel>> call({
    required DebatesStatus status,
  }) async {
    return await repository.getAnnouncedDebates(status: status);
  }
}
