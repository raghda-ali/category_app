import 'dart:convert';

import 'package:category_app_demo/core/constants/app_strings.dart';
import 'package:category_app_demo/core/error/exceptions.dart';
import 'package:category_app_demo/core/error/failures.dart';
import 'package:category_app_demo/features/home_category/data/data_sources/category_remote_data_source.dart';
import 'package:category_app_demo/features/home_category/data/models/category_model.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../fixtures/fixture.reader.dart';

class MockDio extends Mock implements dio.Dio {}

void main() {
  late CategoryRemoteDataSourceImpl remoteDataSourceImpl;
  late MockDio mockDio;
  setUp(() {
    mockDio = MockDio();
    remoteDataSourceImpl = CategoryRemoteDataSourceImpl(mockDio);
  });
  void setUpMockDioSuccess200() {
    when(() => mockDio.get(
          "${AppStrings.baseUrl}get_category",
        )).thenAnswer(
      (_) async => dio.Response(
        data: jsonDecode(fixture('category.json')) as Map<String, dynamic>,
        statusCode: 200,
        requestOptions: RequestOptions(
          path: "${AppStrings.baseUrl}get_category",
        ),
      ),
    );
  }

  void setUpMockDioError404() {
    when(() => mockDio.get(
          "${AppStrings.baseUrl}get_category",
        )).thenAnswer(
      (_) async => dio.Response(
        data: {"Something wrong"},
        statusCode: 404,
        requestOptions: RequestOptions(
          path: "${AppStrings.baseUrl}get_category",
        ),
      ),
    );
  }
  final List<Category> emptyCategoryList= [];
  final List<Category> categoryList = [];
  final jsonMap = jsonDecode(fixture('category.json')) as Map<String, dynamic>;
  for (int i = 0; i < (jsonMap['Category'] as List).length; i++) {
    categoryList.add(
        CategoryModel.fromJson(jsonMap['Category'][i] as Map<String, dynamic>));
  }
  group('getHomeCategory', () {
    test('should return Category List when the response is 200(success)',
        () async {
      //arrange
      setUpMockDioSuccess200();
      //act
      final result = await remoteDataSourceImpl.getHomeCategory();
      //assert
      verify(() => mockDio.get(
            "${AppStrings.baseUrl}get_category",
          ));
      expect(result, categoryList);
    });
    test('should return ServerException when the response is 404', () async {
      //arrange
      setUpMockDioError404();
      //act
      final result = remoteDataSourceImpl.getHomeCategory();
      //assert
      expect(result, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
