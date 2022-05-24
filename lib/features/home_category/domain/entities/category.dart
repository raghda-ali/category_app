import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String image;
  final String color;

  const Category({
    required this.id,
    required this.name,
    required this.image,
    required this.color,
  });

  @override
  List<Object?> get props => [id, name, image, color];
}
