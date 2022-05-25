import 'package:category_app_demo/core/error/exceptions.dart';
import 'package:category_app_demo/core/error/failures.dart';
import 'package:category_app_demo/core/platform/network_info.dart';
import 'package:category_app_demo/features/home_category/data/data_sources/category_remote_data_source.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:category_app_demo/features/home_category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Category>>> getHomeCategories() async {
    await networkInfo.isConnected;
    try {
      return Right(await remoteDataSource.getHomeCategory());
    } on ServerException {
      return Left(ServerFailure());
    }
    on CacheException {
      return Left(CacheFailure());
    }
  }
}
