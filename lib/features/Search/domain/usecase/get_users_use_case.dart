import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Search/data/models/user_model.dart';
import 'package:poi/features/Search/domain/repo/search_repo.dart';

class GetUsersUseCase {
  final SearchRepo searchRepo;

  GetUsersUseCase({required this.searchRepo});

  Future<Either<Failure, UserModel>> call() async {
    return searchRepo.getUsers();
  }
}
