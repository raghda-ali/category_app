import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:category_app_demo/features/home_category/domain/repositories/category_repository.dart';
import 'package:category_app_demo/features/home_category/domain/use_cases/get_home_categories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
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
      color: "#e7eddd",
    ),
  ];
  print(categoryList);
  test('should get list of home category from the repository', () async {
    //arrange
    when(() => mockCategoryRepository.getHomeCategories())
        .thenAnswer((_) async => Right(categoryList));
    final result = await categoryUseCase.getCategories();
    print(result);
    expect(result, Right(categoryList));
    verify(() => mockCategoryRepository.getHomeCategories());
    verifyNoMoreInteractions(mockCategoryRepository);
  });
}
