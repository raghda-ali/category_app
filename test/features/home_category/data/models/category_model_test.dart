import 'dart:convert';

import 'package:category_app_demo/features/home_category/data/models/category_model.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.reader.dart';

void main() {
  const category = CategoryModel(
    id: 1,
    name: "Super market",
    image: "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
    color: "#e7eddd",
  );
  test('should be a subclass of category entity', () {
    expect(category, isA<Category>());
  });
  test('should return a valid json model', () async {
    //arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('category.json'));
    //act
    final result = CategoryModel.fromJson(jsonMap);
    //assert
    expect(result, category);
  });
  test('should return a json map containing data', () async {
    //arrange
    final result = category.toJson();
    final expectedJsonMap = {
      "id": 1,
      "name": "Super market",
      "image": "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
      "color":"#e7eddd",
    };
    //act
    expect(result, expectedJsonMap);
  });
}
