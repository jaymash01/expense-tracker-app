import 'package:equatable/equatable.dart';

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
