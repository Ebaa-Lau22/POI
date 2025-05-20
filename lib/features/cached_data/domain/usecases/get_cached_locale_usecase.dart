import 'package:dartz/dartz.dart';
import 'package:poi/features/cached_data/domain/repositories/cache_repository.dart';
import '../../../../core/error/failures.dart';


class GetCachedLocaleUseCase{
  final CacheRepository repository;

  GetCachedLocaleUseCase({required this.repository});

  Future<Either<Failure, String>> call() async{
    return await repository.getCachedLocale();
  }
}