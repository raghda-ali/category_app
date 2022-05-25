import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:dio/dio.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getHomeCategory();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Category>> getHomeCategory() {
    // TODO: implement getHomeCategory
    throw UnimplementedError();
  }
}
