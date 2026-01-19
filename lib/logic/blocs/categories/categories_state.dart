import 'package:expense_tracker/data/models/category_model.dart';

class CategoriesState {
  final List<Category> categories;
  final bool isLoading;

  CategoriesState({required this.categories, this.isLoading = false});

  CategoriesState copyWith({List<Category>? categories, bool? isLoading}) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
