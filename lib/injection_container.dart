import 'package:category_app_demo/core/platform/network_info.dart';
import 'package:category_app_demo/features/home_category/data/data_sources/category_remote_data_source.dart';
import 'package:category_app_demo/features/home_category/domain/repositories/category_repository.dart';
import 'package:category_app_demo/features/home_category/domain/use_cases/get_home_categories.dart';
import 'package:category_app_demo/features/home_category/presentation/logic/category_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart' as dio;
import 'features/home_category/data/repositories/category_repository_impl.dart';

final sl = GetIt.instance;

void init() {
  //Cubit
  sl.registerFactory(() => CategoryCubit(homeCategoriesUseCase: sl()));
  //UseCases
  sl.registerLazySingleton(() => GetHomeCategories(sl()));
  //Repository
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  //DataSources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => dio.Dio);
}
