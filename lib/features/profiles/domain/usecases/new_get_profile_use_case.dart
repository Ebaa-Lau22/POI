import 'package:dartz/dartz.dart';
import 'package:poi/core/app_models/new_profile_model.dart';
import 'package:poi/features/profiles/domain/repositories/new_profile_respository.dart';
import '../../../../core/error/failures.dart';

class NewGetProfileUseCase {
  final NewProfileRespository repository;

  NewGetProfileUseCase({required this.repository});

  Future<Either<Failure, NewProfileModel>> call() async {
    return await repository.getProfile();
  }
}
