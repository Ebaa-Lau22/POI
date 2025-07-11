import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/features/Authentication/data/datasources/auth_remote_data_source.dart';
import 'package:poi/features/Authentication/data/repositories/auth_repository_imp.dart';
import 'package:poi/features/Authentication/domain/repositories/auth_repository.dart';
import 'package:poi/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:poi/features/Authentication/domain/usecases/resetPassword_usecase.dart';
import 'package:poi/features/Authentication/domain/usecases/sendCode_usecase.dart';
import 'package:poi/features/Authentication/domain/usecases/verifyCode_usecase.dart';
import 'package:poi/features/Authentication/presentation/bloc/auth_cubit.dart';
import 'package:poi/features/cached_data/data/datasources/cache_local_data_source.dart';
import 'package:poi/features/cached_data/data/repositories/cache_repository_impl.dart';
import 'package:poi/features/cached_data/domain/repositories/cache_repository.dart';
import 'package:poi/features/cached_data/domain/usecases/cache_locale_use_case.dart';
import 'package:poi/features/cached_data/domain/usecases/cache_theme_use_case.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_locale_usecase.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_theme_usecase.dart';
import 'package:poi/features/call/call_cubit.dart';
import 'package:poi/features/call/connection_cubit.dart';
import 'package:poi/features/debate_setup/data/datasources/debate_setup_remote_datasource.dart';
import 'package:poi/features/debate_setup/data/repositories/debate_setup_repository_imp.dart';
import 'package:poi/features/debate_setup/domain/repositories/debate_setup_repository.dart';
import 'package:poi/features/debate_setup/domain/usecases/add_motion_usecase.dart';
import 'package:poi/features/debate_setup/domain/usecases/get_all_motions_usecase.dart';
import 'package:poi/features/debate_setup/domain/usecases/get_all_topics_usecase.dart';
import 'package:poi/features/debate_setup/presentation/bloc/debate_setup_cubit.dart';
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

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Posts
  sl.registerFactory(
    () => PostsCubit(
      getAllPostsUseCase: sl(),
      addPostUseCase: sl(),
      updatePostUseCase: sl(),
      deletePostUseCase: sl(),
    ),
  );

  //! Cubits
  sl.registerFactory(() => CallCubit());
  sl.registerFactory(() => PermissionCubit());
  sl.registerFactory(
    () =>
        DebateSetupCubit(getAllMotionsUsecase: sl(), getAllTopicsUsecase: sl()),
  );
  sl.registerFactory(() => ConnectionCubit());
  sl.registerFactory(
    () => AppCubit(cacheThemeUseCase: sl(), cacheLocaleUseCase: sl()),
  );
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      sendCodeUseCase: sl(),
      verifyCodeUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );

  //! Use Cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddPostUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl()));
  //Cache
  sl.registerLazySingleton(() => CacheThemeUseCase(repository: sl()));
  sl.registerLazySingleton(() => CacheLocaleUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedLocaleUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCachedThemeUseCase(repository: sl()));
  //Login
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  //Reset Password
  sl.registerLazySingleton(() => SendCodeUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => VerifyCodeUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(authRepository: sl()));
  //Motions
  sl.registerLazySingleton(() => GetAllMotionsUsecase(debateRepo: sl()));
  sl.registerLazySingleton(() => GetAllTopicsUsecase(debateRepo: sl()));
  sl.registerLazySingleton(() => AddMotionUsecase(debateRepo: sl()));

  //! Repositories
  sl.registerLazySingleton<PostsRepository>(
    () => PostRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<CacheRepository>(
    () => CacheRepositoryImpl(dataSource: sl()),
  ); //Cache
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  ); //Auth
  sl.registerLazySingleton<DebateSetupRepository>(
    () => DebateSetupRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()),
  ); //Setup

  //! Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CacheLocalDataSource>(
    () => CacheLocalDataSourceImpl(db: sl()),
  ); //Cache
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  ); //Auth
  sl.registerLazySingleton<DebateSetupRemoteDatasource>(
    () => DebateSetupRemoteDatasourceImpl(client: sl()),
  ); //Setup

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => PreferencesDatabase());

  //! External
  sl.registerFactory(() => http.Client());
  sl.registerFactory(() => InternetConnectionChecker());
}
