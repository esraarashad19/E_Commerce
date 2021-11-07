import 'package:e_commerce_app/models/home_model.dart';

class CartsModel {
  late bool status;
  String? message;
  CartsDetails? data;

  CartsModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CartsDetails.fromMap(json['data']) : null;
  }
}

class CartsDetails {
  late dynamic subTotal;
  late dynamic total;
  List<CartItem> cartsItems = [];
  CartsDetails.fromMap(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    total = json['total'];
    for (var cartItem in json['cart_items'])
      cartsItems.add(CartItem.fromMap(cartItem));
  }
}

class CartItem {
  late int id;
  late int quantity;
  late ProductModel product;
  CartItem.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = ProductModel.fromMap(json['product']);
  }
}
