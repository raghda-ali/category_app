import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:category_app_demo/features/home_category/domain/repositories/category_repository.dart';
import 'package:category_app_demo/features/home_category/domain/use_cases/get_home_categories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

Future<void> main() async {
  late GetHomeCategories categoryUseCase;
  late MockCategoryRepository mockCategoryRepository;
  setUp(() {
    mockCategoryRepository = MockCategoryRepository();
    categoryUseCase = GetHomeCategories(mockCategoryRepository);
  });
  List<Category> categoryList = [
    const Category(
        id: 1,
        name: "Super market",
        image: "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
        color: "#e7eddd"),
  ];
  test(
      'should get list of home category from the repository',
      () async {
            //arrange
            when(() => mockCategoryRepository.getHomeCategories())
                .thenAnswer((_) async => Right(categoryList));
          });
  //act
  final result = await categoryUseCase.call();
  expect(result, Right(categoryList));
  verify(() => mockCategoryRepository.getHomeCategories());
}
