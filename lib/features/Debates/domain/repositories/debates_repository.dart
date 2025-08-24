import 'package:poi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';

abstract class DebatesRepository {
  Future<Either<Failure, DebatesModel>> getAnnouncedDebates({required int currentPage});
}