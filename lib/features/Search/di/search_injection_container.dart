import 'package:poi/di/injection_container.dart';
import 'package:poi/features/Search/data/datasource/search_remote_data_source.dart';
import 'package:poi/features/Search/data/repo/search_repo_impl.dart';
import 'package:poi/features/Search/domain/repo/search_repo.dart';
import 'package:poi/features/Search/domain/usecase/get_finished_debates_use_case.dart';
import 'package:poi/features/Search/domain/usecase/get_users_use_case.dart';
import 'package:poi/features/Search/presentation/bloc/search_cubit.dart';

void initSearchInjectionContainer() {
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(apiServices: sl()),
  );
  sl.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(searchRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<GetFinishedDebatesUseCase>(
    () => GetFinishedDebatesUseCase(searchRepo: sl()),
  );
  sl.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(searchRepo: sl()),
  );
  sl.registerFactory<SearchCubit>(
    () => SearchCubit(getUsersUseCase: sl(), getFinishedDebatesUseCase: sl()),
  );
}
