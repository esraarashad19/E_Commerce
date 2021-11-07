import 'package:e_commerce_app/models/home_model.dart';

class CategoryProductsModel {
  late bool status;
  String? message;
  DataDetails? data;
  CategoryProductsModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataDetails(json['data']) : null;
  }
}

class DataDetails {
  List<ProductModel> categoryProducts = [];
  DataDetails(Map<String, dynamic> json) {
    for (var product in json['data'])
      categoryProducts.add(ProductModel.fromMap(product));
  }
}
