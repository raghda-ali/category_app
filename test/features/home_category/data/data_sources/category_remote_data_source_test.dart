import 'package:category_app_demo/features/home_category/data/data_sources/category_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CategoryRemoteDataSourceImpl remoteDataSourceImpl;
  late Dio dio;
  setUp(() {
    dio = Dio();
    remoteDataSourceImpl = CategoryRemoteDataSourceImpl(dio);
  });
  test('getCategory', () {

  });
}
