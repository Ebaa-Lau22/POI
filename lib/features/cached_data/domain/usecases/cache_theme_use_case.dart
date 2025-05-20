import 'package:dartz/dartz.dart';
import 'package:poi/features/cached_data/domain/repositories/cache_repository.dart';
import '../../../../core/error/failures.dart';


class CacheThemeUseCase{
  final CacheRepository repository;

  CacheThemeUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({required String theme}) async{
    return await repository.cacheTheme(theme: theme);
  }
}