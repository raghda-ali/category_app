import 'package:category_app_demo/core/platform/network_info.dart';
import 'package:category_app_demo/features/home_category/data/data_sources/category_remote_data_source.dart';
import 'package:category_app_demo/features/home_category/data/repositories/category_repository_impl.dart';
import 'package:category_app_demo/features/home_category/domain/repositories/category_repository.dart';
import 'package:category_app_demo/features/home_category/domain/use_cases/get_home_categories.dart';
import 'package:category_app_demo/features/home_category/presentation/logic/category_cubit.dart';
import 'package:category_app_demo/features/home_category/presentation/pages/category.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(
          homeCategoriesUseCase: GetHomeCategories(
              categoryRepository: CategoryRepositoryImpl(
                  networkInfo: NetworkInfoImpl(
                      dataConnectionChecker: DataConnectionChecker()),
                  remoteDataSource: CategoryRemoteDataSourceImpl(dio: Dio()))))
        ..getHomeCategory(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CategoryScreen(),
      ),
    );
  }
}
