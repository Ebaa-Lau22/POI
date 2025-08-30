import 'package:dartz/dartz.dart';
import 'package:poi/core/app_models/new_profile_model.dart';
import 'package:poi/core/error/failures.dart';

abstract class NewProfileRespository {
  Future<Either<Failure, NewProfileModel>> getProfile();
}
