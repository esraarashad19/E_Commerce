class CategoryModel {
  late bool status;
  String? message;
  CategoryDetails? data;
  CategoryModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CategoryDetails.fromMap(json['data']) : null;
  }
}

class CategoryDetails {
  late List<Category> categoriesList = [];

  CategoryDetails.fromMap(Map<String, dynamic> json) {
    for (var category in json['data'])
      categoriesList.add(Category.fromMap(category));
  }
}

class Category {
  late int id;
  late String image;
  late String name;
  Category.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] ?? '';
    name = json['name'] ?? '';
  }
}
