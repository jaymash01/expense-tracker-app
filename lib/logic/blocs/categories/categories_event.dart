import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/category_model.dart';

class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoriesEvent {
  final Map<String, dynamic>? params;

  const LoadCategories(this.params);

  @override
  List<Object?> get props => [params];
}

class DeleteCategory extends CategoriesEvent {
  final Category category;
  final VoidCallback? onSuccess;

  const DeleteCategory(this.category, this.onSuccess);

  @override
  List<Object?> get props => [category, onSuccess];
}
