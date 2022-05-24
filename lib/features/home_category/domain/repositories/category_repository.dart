import 'package:category_app_demo/core/error/failures.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getHomeCategories();
}
