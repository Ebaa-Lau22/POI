import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Search/data/models/user_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, UserModel>> getUsers();
  Future<Either<Failure, DebateModel>> getFinishedDebates();
}
