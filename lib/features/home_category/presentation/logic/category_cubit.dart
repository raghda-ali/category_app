import 'package:bloc/bloc.dart';
import 'package:category_app_demo/core/error/failures.dart';
import 'package:category_app_demo/features/home_category/domain/entities/category.dart';
import 'package:category_app_demo/features/home_category/domain/use_cases/get_home_categories.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String UNEXPECTED_ERROR = 'Unexpected Error';

class CategoryCubit extends Cubit<CategoryState> {
  final GetHomeCategories homeCategoriesUseCase;

  CategoryCubit({required this.homeCategoriesUseCase})
      : super(CategoryInitial());

  Future<void> getHomeCategory() async {
    emit(CategoryLoading());
    final failureOrData = await homeCategoriesUseCase.getCategories();
    failureOrData.fold(
        (failure) => emit(CategoryError(errorMessage: _mapFailureToMessage(failure))),
        (data) => emit(CategorySuccess(homeCategoryList: data)));
    print(state.toString());
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR;
    }
  }

}
