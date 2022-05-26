import 'package:category_app_demo/core/error/exceptions.dart';
import 'package:category_app_demo/core/error/failures.dart';
import 'package:category_app_demo/features/home_category/data/models/category_model.dart';
import 'package:category_app_demo/features/home_category/domain/use_cases/get_home_categories.dart';
import 'package:category_app_demo/features/home_category/presentation/logic/category_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetHomeCategory extends Mock implements GetHomeCategories {}

void main() {
  late MockGetHomeCategory mockGetHomeCategory;
  late CategoryCubit categoryCubit;
  setUp(() {
    mockGetHomeCategory = MockGetHomeCategory();
    categoryCubit = CategoryCubit(homeCategoriesUseCase: mockGetHomeCategory);
  });
  List<CategoryModel> categoryList = [
    const CategoryModel(
      id: 1,
      name: "Super market",
      image: "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
      color: "#e7eddd",
    ),
  ];
  group('getHomeCategory', () {
    test('should emit [Loading,Success] when data is gotten successfully',
        () async {
      //arrange
      when(() => mockGetHomeCategory.getCategories())
          .thenAnswer((invocation) async => Right(categoryList));
      //act
      final expected = [
        CategoryLoading(),
        CategorySuccess(homeCategoryList: categoryList),
      ];
      //assert
      expect(categoryCubit.stream, emitsInOrder(expected));
      await categoryCubit.getHomeCategory();
    });
    test('should emit [Loading,Error] when data fail', () async {
      //arrange
      when(() => mockGetHomeCategory.getCategories())
          .thenAnswer((invocation) async => Left(ServerFailure()));
      //act
      final expected = [
        CategoryLoading(),
        CategoryError(errorMessage: "Server Failure"),
      ];
      //assert
      expect(categoryCubit.stream, emitsInOrder(expected));
      await categoryCubit.getHomeCategory();
    });
    test('should emit [Loading,Error] when data cache', () async {
      //arrange
      when(() => mockGetHomeCategory.getCategories())
          .thenAnswer((invocation) async => Left(CacheFailure()));
      //act
      final expected = [
        CategoryLoading(),
        CategoryError(errorMessage: "Cache Failure"),
      ];
      //assert
      expect(categoryCubit.stream, emitsInOrder(expected));
      await categoryCubit.getHomeCategory();
    });
  });
}
