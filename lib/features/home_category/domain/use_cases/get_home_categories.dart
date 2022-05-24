import 'package:category_app_demo/core/error/failures.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:category_app_demo/features/home_category/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetHomeCategories {
  final CategoryRepository categoryRepository;

  GetHomeCategories(this.categoryRepository);

  Future<Either<Failure, List<Category>>> call() async {
    return await categoryRepository.getHomeCategories();
  }
}
