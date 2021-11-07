import 'package:e_commerce_app/models/home_model.dart';

class SearchModel {
  late bool status;
  String? message;
  SearchDetails? data;
  SearchModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SearchDetails.fromMap(json['data']) : null;
  }
}

class SearchDetails {
  late int total;
  List<ProductModel> searchResultList = [];
  SearchDetails.fromMap(Map<String, dynamic> json) {
    total = json['total'];
    json['data'].forEach((element) {
      searchResultList.add(ProductModel.fromMap(element));
    });
  }
}
