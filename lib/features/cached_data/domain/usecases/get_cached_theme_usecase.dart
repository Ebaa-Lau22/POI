import 'package:dartz/dartz.dart';
import 'package:poi/features/cached_data/domain/repositories/cache_repository.dart';
import '../../../../core/error/failures.dart';


class GetCachedThemeUseCase{
  final CacheRepository repository;

  GetCachedThemeUseCase({required this.repository});

  Future<Either<Failure, String>> call() async{
    return await repository.getCachedTheme();
  }
}