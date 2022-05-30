import 'dart:convert';

import 'package:category_app_demo/features/home_category/data/models/category_model.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture.reader.dart';

void main() {
  const categoryList = [
    CategoryModel(
      id: 1,
      name: "مطاعم",
      image: "https://ta3alapp.com/ta3al/images/category/623c53655e05a.jpg",
      color: "#ededed",
    ),
    CategoryModel(
      id: 2,
      name: "سوبر ماركت",
      image: "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
      color: "#e7eddd",
    ),
    CategoryModel(
      id: 3,
      name: "صيدليه",
      image: "https://ta3alapp.com/ta3al/images/category/623c53942290e.jpg",
      color: "#cca9be",
    ),
    CategoryModel(
      id: 4,
      name: "مشروبات",
      image: "https://ta3alapp.com/ta3al/images/category/623c4a4688b4e.jpg",
      color:  "#d8e3eb",
    ),
    CategoryModel(
      id: 5,
      name:"مأكولات",
      image:"https://ta3alapp.com/ta3al/images/category/623c4ad1b8295.jpg",
      color: "#dae5ed",
    ),
  ];
  const category = CategoryModel(
    id: 1,
    name: "مطاعم",
    image: "https://ta3alapp.com/ta3al/images/category/623c53655e05a.jpg",
    color: "#ededed",
  );
  test('should be a subclass of category entity', () {
    expect(category, isA<Category>());
  });
  test('should return a valid json model', (){
    //arrange
    final jsonMap =
        jsonDecode(fixture('category.json')) as Map<String, dynamic>;
    for (int i = 0; i < (jsonMap['Category'] as List).length; i++) {
      final result = CategoryModel.fromJson(
          jsonMap['Category'][i] as Map<String, dynamic>);
      expect(result, categoryList[i]);
    }
  });
  test('should return a json map containing data', () async {
    //arrange
    final result = category.toJson();
    final expectedJsonMap = {
      "id": 1,
      "name": "Super market",
      "image": "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
      "color": "#e7eddd",
    };
    //act
    expect(result, expectedJsonMap);
  });
}
