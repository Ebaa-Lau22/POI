import 'package:dartz/dartz.dart';
import 'package:poi/features/cached_data/domain/repositories/cache_repository.dart';
import '../../../../core/error/failures.dart';


class CacheLocaleUseCase{
  final CacheRepository repository;

  CacheLocaleUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required String locale}) async{
    return await repository.cacheLocale(locale: locale);
  }
}