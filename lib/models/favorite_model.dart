import 'package:e_commerce_app/models/home_model.dart';

class FavoritesModel {
  late bool status;
  String? message;
  FavoriteDetails? data;
  FavoritesModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavoriteDetails.fromMap(json['data']) : null;
  }
}

class FavoriteDetails {
  List<ProductModel> wishList = [];

  FavoriteDetails.fromMap(Map<String, dynamic> json) {
    for (var favorite in json['data'])
      wishList.add(ProductModel.fromMap(favorite['product']));
  }
}

class Favorite {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String name;
  late String image;
  late bool inFavorites;
  Favorite.fromMap(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    inFavorites = true;
  }
}
