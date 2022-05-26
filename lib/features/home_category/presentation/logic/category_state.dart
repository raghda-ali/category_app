part of 'category_cubit.dart';

@immutable
abstract class CategoryState extends Equatable {}

class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryError extends CategoryState {
  final String errorMessage;

  CategoryError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class CategorySuccess extends CategoryState {
  final List<Category> homeCategoryList;

  CategorySuccess({required this.homeCategoryList});

  @override
  List<Object?> get props => [homeCategoryList];
}

class CategoryEmpty extends CategoryState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
