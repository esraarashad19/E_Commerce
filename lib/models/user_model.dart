class UserModel {
  late bool status;
  String? message;
  UserModelDetails? data;

  UserModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserModelDetails.fromMap(json['data']) : null;
  }
}

class UserModelDetails {
  late int id;
  late String name;
  late String password;
  late String phone;
  late String token;
  late String image;
  late String email;
  UserModelDetails.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    token = json['token'] ?? '';
  }
}
