import 'package:dartz/dartz.dart';
import 'package:poi/core/app_models/profile_model.dart';
import 'package:poi/features/profiles/domain/repositories/profile_repository.dart';
import '../../../../core/error/failures.dart';

class GetProfileUseCase{
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  Future<Either<Failure, ProfileModel>> call() async{
    return await repository.getProfile();
  }
}