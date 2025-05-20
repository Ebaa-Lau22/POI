import 'package:dartz/dartz.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/cached_data/data/datasources/cache_local_data_source.dart';
import 'package:poi/features/cached_data/domain/repositories/cache_repository.dart';

class CacheRepositoryImpl extends CacheRepository{
  final CacheLocalDataSource dataSource;

  CacheRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Unit>> cacheLocale({required String locale}) async{
    return await _caching((){
      return dataSource.cacheLocale(locale: locale);
    });
  }

  @override
  Future<Either<Failure, Unit>> cacheTheme({required String theme}) async{
    return await _caching((){
      return dataSource.cacheTheme(theme: theme);
    });
  }

  @override
  Future<Either<Failure, String>> getCachedLocale() async{
    try{
      final String locale = await dataSource.getCachedLocale() ?? "en";
      return Right(locale);
    } on EmptyCacheException{
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getCachedTheme() async{
    try{
      final String theme = await dataSource.getCachedTheme() ?? "Light";
      return Right(theme);
    } on EmptyCacheException{
      return Left(EmptyCacheFailure());
    }
  }

  Future<Either<Failure, Unit>> _caching(
      Future<Unit> Function() cacheFunction) async {
    try {
      cacheFunction();
      return const Right(unit);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }
}