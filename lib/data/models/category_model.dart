class Category {
  int id;
  String name;
  String? description;

  Category({required this.id, required this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class CreateCategoryResponse {
  String message;
  Category? data;

  CreateCategoryResponse({required this.message, this.data});

  factory CreateCategoryResponse.fromJson(Map<String, dynamic> json) {
    return CreateCategoryResponse(
      message: json['message'],
      data: json['data'] != null ? Category.fromJson(json['data']) : null,
    );
  }
}

class CategoriesResponse {
  int total;
  int page;
  List<Category> data = [];

  CategoriesResponse({
    required this.total,
    required this.page,
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      total: json['data']['total'],
      page: json['data']['current_page'],
      data: List<Category>.from(
        json['data']['data'].map((model) => Category.fromJson(model)),
      ),
    );
  }
}

class CategoryDetailsResponse {
  String message;
  Category? data;

  CategoryDetailsResponse({required this.message, required this.data});

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CategoryDetailsResponse(
      message: json['message'],
      data: json['data'] != null ? Category.fromJson(json['data']) : null,
    );
  }
}

class DeleteCategoryResponse {
  String message;
  Category? data;

  DeleteCategoryResponse({required this.message, this.data});

  factory DeleteCategoryResponse.fromJson(Map<String, dynamic> json) {
    return DeleteCategoryResponse(
      message: json['message'],
      data: json['data'] != null ? Category.fromJson(json['data']) : null,
    );
  }
}
