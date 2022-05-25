import 'dart:convert';

import 'package:category_app_demo/features/home_category/data/data_sources/category_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../fixtures/fixture.reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CategoryRemoteDataSourceImpl remoteDataSourceImpl;
  late Dio mockDio;
  setUp(() {
    mockDio = Dio();
    remoteDataSourceImpl = CategoryRemoteDataSourceImpl(mockDio);
  });
  group('getHomeCategory', () {
    test('should perform a GET request on a URL', () {
      //arrange
      when(() => mockDio.get(
          'https://ta3alapp.com/ta3al/Api/customer/get_category')).thenAnswer(
        (_) async => dio.Response(
          data: jsonDecode(fixture('category.json')) as Map<String, dynamic>,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
      //act
      remoteDataSourceImpl.getHomeCategory();
      //assert
      verify(() => mockDio.get(
            'https://ta3alapp.com/ta3al/Api/customer/get_category',
          ));
    });

    test('sh', () {

    });
  });
}
