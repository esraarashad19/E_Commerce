class OrdersModel {
  late bool status;
  String? message;
  OrdersDetails? data;
  OrdersModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? OrdersDetails.fromMap(json['data']) : null;
  }
}

class OrdersDetails {
  List<Order> orders = [];
  OrdersDetails.fromMap(Map<String, dynamic> json) {
    for (var order in json['data']) {
      Order or = Order.fromMap(order);
      if (or.status == 'New' || or.status == 'جديد') orders.add(or);
    }
  }
}

class Order {
  late int id;
  late dynamic total;
  late String date;
  late String status;
  Order.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}
