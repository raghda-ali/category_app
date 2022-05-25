import 'package:category_app_demo/features/home_category/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required int id,
    required String name,
    required String image,
    required String color,
  }) : super(
          id: id,
          name: name,
          image: image,
          color: color,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        color: json['color']);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": 1,
      "name": "Super market",
      "image": "https://ta3alapp.com/ta3al/images/category/623c533878201.jpg",
      "color": "#e7eddd",
    };
  }
}
