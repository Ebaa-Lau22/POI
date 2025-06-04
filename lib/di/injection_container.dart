import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/features/cached_data/data/datasources/cache_local_data_source.dart';
import 'package:poi/features/cached_data/data/repositories/cache_repository_impl.dart';
import 'package:poi/features/cached_data/domain/repositories/cache_repository.dart';
import 'package:poi/features/cached_data/domain/usecases/cache_locale_use_case.dart';
import 'package:poi/features/cached_data/domain/usecases/cache_theme_use_case.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_locale_usecase.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_theme_usecase.dart';
import 'package:poi/features/call/call_cubit.dart';
import 'package:poi/features/call/connection_cubit.dart';
import 'package:poi/permission_cubit.dart';
import '../core/storage/preferences_database.dart';
import '../core/network/network_info.dart';
import '../features/posts/data/datasources/post_remote_data_source.dart';
import '../features/posts/data/repositories/post_repository_impl.dart';
import '../features/posts/domain/repositories/posts_repository.dart';
import '../features/posts/domain/usecases/add_post.dart';
import '../features/posts/domain/usecases/delete_post.dart';
import '../features/posts/domain/usecases/get_all_posts.dart';
import '../features/posts/domain/usecases/update_post.dart';
import '../features/posts/presentation/bloc/posts_cubit.dart';
import '../features/team_assignment/presentation/bloc/team_assignment_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Posts
  sl.registerFactory(() => PostsCubit(
    getAllPostsUseCase: sl(),
    addPostUseCase: sl(),
    updatePostUseCase: sl(),
    deletePostUseCase: sl(),
  ));

  //! Cubits
  sl.registerFactory(() => CallCubit());
  sl.registerFactory(() => PermissionCubit());
  sl.registerFactory(() => TeamAssignmentCubit());
  sl.registerFactory(() => ConnectionCubit());
  sl.registerFactory(() => AppCubit(
    cacheThemeUseCase: sl(),
    cacheLocaleUseCase: sl(),
  ));


  //! Use Cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => CacheThemeUseCase(repository: sl()));
  sl.registerLazySingleton(() => CacheLocaleUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedLocaleUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedThemeUseCase(repository: sl()));


  //! Repositories
  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(
    remoteDataSource: sl(),
    networkInfo: sl(),
  ));
  sl.registerLazySingleton<CacheRepository>(() => CacheRepositoryImpl(
    dataSource: sl(),
  ));

  //! Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CacheLocalDataSource>(() => CacheLocalDataSourceImpl(db: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => PreferencesDatabase());

  //! External
  sl.registerFactory(() => http.Client());
  sl.registerFactory(() => InternetConnectionChecker());
}
