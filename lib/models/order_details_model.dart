class OrderDetailsModel {
  late bool status;
  String? message;
  OrderDetails? data;
  OrderDetailsModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrderDetails.fromMap(json['data']) : null;
  }
}

class OrderDetails {
  late int id;
  late dynamic total;
  late String date;
  late String status;
  late String payment;
  late AddressModel address;
  List<OrderProduct> products = [];
  OrderDetails.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
    payment = json['payment_method'];
    address = AddressModel.fromMap(json['address']);
    for (var product in json['products'])
      products.add(OrderProduct.fromMap(product));
  }
}

class AddressModel {
  late int id;
  late String name;
  late String city;
  late String region;
  late String details;
  String? notes;
  AddressModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    notes = json['notes'];
    details = json['details'];
  }
}

class OrderProduct {
  late int id;
  late String name;
  late String image;
  late int quantity;
  OrderProduct.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
  }
}
