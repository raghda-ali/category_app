import 'dart:convert';

import 'package:category_app_demo/core/constants/app_strings.dart';
import 'package:category_app_demo/core/error/exceptions.dart';
import 'package:category_app_demo/features/home_category/data/models/category_model.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:dio/dio.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getHomeCategory();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Category>> getHomeCategory() async {
    List<Category> categoriesList = [];
    final response =
        await dio.get("${AppStrings.baseUrl}get_category");
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonList = (response.data as Map<String, dynamic>)['Category'];
      for (final category in jsonList) {
        categoriesList
            .add(CategoryModel.fromJson(category as Map<String, dynamic>));
      }
      print(categoriesList);
      return categoriesList;
    } else{
      throw ServerException();
    }
  }
}
