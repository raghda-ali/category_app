import 'package:category_app_demo/core/error/exceptions.dart';
import 'package:category_app_demo/core/error/failures.dart';
import 'package:category_app_demo/core/platform/network_info.dart';
import 'package:category_app_demo/features/home_category/data/data_sources/category_remote_data_source.dart';
import 'package:category_app_demo/features/home_category/data/repositories/category_repository_impl.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements CategoryRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CategoryRepositoryImpl categoryRepositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    categoryRepositoryImpl = CategoryRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });
  // test('should check the device is online', () {
  //   when(()=> mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  // });
  group('getCategory', () {
    List<Category> categoryList = [
      const Category(
        id: 1,
        name: "Super market",
        image: "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
        color: "#e7eddd",
      ),
    ];
    test('should check the device is online', () {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getHomeCategory())
          .thenAnswer((_) async => categoryList);
      //act
      categoryRepositoryImpl.getHomeCategories();
      //assert
      verify(() => mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return remote data when the call to remote data source is success',
          () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.getHomeCategory())
            .thenAnswer((_) async => categoryList);
        //act
        final result = await categoryRepositoryImpl.getHomeCategories();
        print(result);
        print(categoryList);
        //assert
        verify(() => mockRemoteDataSource.getHomeCategory());
        expect(result, equals(Right(categoryList)));
      });
      test(
          'should return server failure when the call to remote is unsuccessful',
          () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.getHomeCategory())
            .thenThrow(ServerException());
        //act
        final result = await categoryRepositoryImpl.getHomeCategories();
        print(result);
        //assert
        verify(() => mockRemoteDataSource.getHomeCategory());
        expect(result, Left(ServerFailure()));
      });
      test('should return cache failure when there is no data', () async {
        //arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockRemoteDataSource.getHomeCategory())
            .thenThrow(CacheException());
        //act
        final result = await categoryRepositoryImpl.getHomeCategories();
        print(result);
        //assert
        verify(() => mockRemoteDataSource.getHomeCategory());
        expect(result, Left(CacheFailure()));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return server failure when device is offline', () async {
        //arrange
        // when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockRemoteDataSource.getHomeCategory())
            .thenThrow(ServerException());
        //act
        final result = await categoryRepositoryImpl.getHomeCategories();
        print(result);
        print(mockNetworkInfo.isConnected);
        //assert
        verify(() => mockRemoteDataSource.getHomeCategory());
        expect(result, Left(ServerFailure()));
      });
    });
  });
}
