import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class SendRequestFromDebaterUseCase {
  final DebatesRepository repository;

  SendRequestFromDebaterUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required int debateid}) async {
    return await repository.sendRequestFromDebater(debateid);
  }
}
