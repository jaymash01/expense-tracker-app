import 'package:expense_tracker/data/models/category_model.dart';
import 'package:expense_tracker/data/repositories/categories_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository = CategoriesRepository();

  CategoriesBloc() : super(CategoriesState(categories: [])) {
    on<LoadCategories>(_onLoadCategories);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      Map<String, dynamic> params = <String, dynamic>{
        'page': '1',
        'per_page': '100',
      };

      if (event.params != null) {
        params.addAll(event.params!);
      }

      CategoriesResponse response = await categoriesRepository.fetchCategories(
        params,
      );

      emit(state.copyWith(isLoading: false, categories: response.data));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      List<Category> categories = state.categories;

      categories.removeWhere((element) => element.id == event.category.id);
      emit(state.copyWith(categories: categories));

      await categoriesRepository.deleteCategory(event.category.id);

      if (event.onSuccess != null) {
        event.onSuccess!();
      }
    } catch (e) {
      // Ignored
    }
  }
}
