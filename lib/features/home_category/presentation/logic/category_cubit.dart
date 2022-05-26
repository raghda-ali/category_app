import 'package:bloc/bloc.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:category_app_demo/features/home_category/domain/use_cases/get_home_categories.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetHomeCategories homeCategoriesUseCase;

  CategoryCubit({required this.homeCategoriesUseCase})
      : super(CategoryInitial());
  Future<List<Category>> getHomeCategory(){
    emit(CategoryLoading());

    return;
  }
}
