class HomeModel {
  late bool status;
  String? message;
  HomeDetails? data;

  HomeModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeDetails.fromMap(json['data']) : null;
  }
}

class HomeDetails {
  List<ProductModel> products = [];
  List<BannerModel> banners = [];

  HomeDetails.fromMap(Map<String, dynamic> json) {
    //   if (json['banners'] != null)
    for (var banner in json['banners'])
      banners.add(BannerModel.fromMap(banner));

    // if (json['products'] != null)
    for (var product in json['products'])
      products.add(ProductModel.fromMap(product));
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late String description;
  late int discount;
  late String image;
  late String name;
  late bool infavorites;
  late bool inCart;

  ProductModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    description = json['description'] ?? '';
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    infavorites = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}

class BannerModel {
  late int id;
  late String image;

  BannerModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] ?? '';
  }
}
