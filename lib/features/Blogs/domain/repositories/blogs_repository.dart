import 'package:poi/core/app_models/profile_model.dart';
import 'package:poi/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure,ProfileModel>> getProfile();
}