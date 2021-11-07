import 'package:e_commerce_app/models/carts_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/shared/end_points.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:e_commerce_app/shared/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/models/search_model.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/category_products_model.dart';
import 'package:e_commerce_app/models/favorite_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

enum Payments { Online, Cache }

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialShopState());
  static ShopCubit get(context) => BlocProvider.of(context);
  var nameController = TextEditingController();
  var regionController = TextEditingController();
  var notesController = TextEditingController();
  var detailsController = TextEditingController();

  int currentIndex = 0;
  int lastScreenIndex = 0;
  int currentViewIndex = 0;
  double offset = 0;
  bool isFavoriteProduct = false;
  bool isDark = false;
  int numberInCart = 0;
  int cartsNumber = 0;
  int whishListsNumber = 0;
  String selectedCity = 'Cairo';
  Payments paymentWay = Payments.Cache;
  var localization = GlobalWidgetsLocalizations.delegate;
  String selectedLanguage = CacheHelper.getData(key: 'lang') != null
      ? CacheHelper.getData(key: 'lang')
      : 'en';

  //models
  HomeModel? homeModel;
  CategoryModel? categoryModel;
  FavoritesModel? favoritesModel;
  CartsModel? cartModel;
  CategoryProductsModel? categoryProductsModel;
  UserModel? userModel;
  SearchModel? searchModel;

  Map<int, bool> favoritesList = {};
  Map<int, bool> inCartList = {};
  Map<int, int> cartItemsQuantity = {};

  // change current index of BottomNavigationBar and moves between in
  void changeCurrentIndex(int index) {
    lastScreenIndex = currentIndex;
    currentIndex = index;
    emit(ChangeNavigationBarShopState());
  }

// change how category product display
  void changeCurrentViewIndex(int index) {
    currentViewIndex = index;
    emit(ChangeCurrentViewState());
  }

// change payment way
  void changePaymentWay(Payments way) {
    paymentWay = way;
    emit(ChangePaymentState());
  }

  //change app Language
  void changeLanguage(String lang) {
    selectedLanguage = lang;
    localization = GlobalWidgetsLocalizations.delegate;
    CacheHelper.saveData(key: 'lang', value: selectedLanguage);
    getHomeProducts();
    getCategories();
    getFavoritesProducts();
    getCarts();

    emit(ChangeLanguageState());
  }

  // change current city
  void changeCurrentCity(String city) {
    selectedCity = city;
    emit(ChangeCityState());
  }

  // enable dark mode
  void changeTheme(bool value) {
    isDark = value;
    emit(ChangeAppThemeState());
  }

//get categories function
  void getCategories() {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(
      endPoint: CATEGORIES,
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      categoryModel = CategoryModel.fromMap(value.data);
      if (categoryModel!.status) {
        print('categories=${categoryModel!.data!.categoriesList.length}');
        emit(GetCategoriesSuccessState());
      } else {
        emit(GetCategoriesErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoriesErrorState(message: error.toString()));
    });
  }

  //get products in category
  void getCategoryDetails(int categoryId) {
    emit(GetCategoryDetailsLoadingState());
    DioHelper.getData(
      endPoint: 'categories/$categoryId',
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      categoryProductsModel = CategoryProductsModel.fromMap(value.data);
      if (categoryProductsModel!.status) {
        print(
            'category id $categoryId=${categoryProductsModel!.data!.categoryProducts.length}');
        emit(GetCategoryDetailsSuccessState());
      } else {
        emit(GetCategoryDetailsErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDetailsErrorState(message: error.toString()));
    });
  }

//get home product
  void getHomeProducts() {
    emit(GetHomeProductsLoadingState());
    DioHelper.getData(
      endPoint: HOME,
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      homeModel = HomeModel.fromMap(value.data);
      print('homeModel=${homeModel.toString()}');
      if (value.data['status']) {
        print('products=${homeModel!.data!.products.length}');
        print('banners=${homeModel!.data!.banners.length}');
        // homeModel!.data!.products.forEach((element) {
        //   favoritesList.addAll({element.id: element.infavorites});
        //   inCartList.addAll({element.id: element.inCart});
        // });
        // print('favoritesList=${favoritesList.length}');
        emit(GetHomeProductsSuccessState());
      } else {
        print('get home products error in else block');
        emit(GetHomeProductsErrorState());
      }
    }).catchError((error) {
      print('get home products error =>${error.toString()}');
      emit(GetHomeProductsErrorState(message: error.toString()));
    });
  }

  //get all shop products
  void getProducts() {
    DioHelper.getData(
      endPoint: 'products',
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      if (value.data['status']) {
        value.data['data']['data'].forEach((element) {
          favoritesList.addAll({element['id']: element['in_favorites']});
          inCartList.addAll({element['id']: element['in_cart']});
        });
        print('favoritesList=${favoritesList.length}');
        print('cartList=${inCartList.length}');
        emit(GetProductsSuccessState());
      } else {
        print('get products error in else block');
        emit(GetProductsErrorState());
      }
    }).catchError((error) {
      print('get  products error =>${error.toString()}');
      emit(GetProductsErrorState(message: error.toString()));
    });
  }

  void searchProducts({required String text}) {
    DioHelper.postData(data: {'text': text}, endPoint: SEARCH).then((value) {
      emit(SearchLoadingState());
      //print('search=${value.data}');
      searchModel = SearchModel.fromMap(value.data);
      if (searchModel!.status) {
        print('searchList=${searchModel!.data!.searchResultList.length}');
        print('total=${searchModel!.data!.total}');
        emit(SearchSuccessState());
      } else {
        emit(SearchErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

//get favorite product
  void getFavoritesProducts() {
    DioHelper.getData(
      endPoint: FAVORITE,
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      emit(GetFavoritesLoadingState());
      favoritesModel = FavoritesModel.fromMap(value.data);
      if (favoritesModel!.status) {
        print('favoritesList=${favoritesModel!.data!.wishList.length}');
        whishListsNumber = favoritesModel!.data!.wishList.length;
        emit(GetFavoritesSuccessState());
      } else {
        // print(categoryModel.status);
        //  print('else block');
        emit(GetFavoritesErrorState(message: favoritesModel!.message));
      }
    }).catchError((error) {
      print(error.toString());
      print(favoritesModel!.message);
      emit(GetFavoritesErrorState(message: error.toString()));
    });
  }

//get carts function
  void getCarts() {
    emit(GetCartsLoadingState());
    DioHelper.getData(
      endPoint: CARTS,
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      cartModel = CartsModel.fromMap(value.data);
      if (cartModel!.status) {
        cartItemsQuantity = {};
        numberInCart = 0;
        cartsNumber = cartModel!.data!.cartsItems.length;
        print('carts=${cartModel!.data!.cartsItems.length}');
        cartModel!.data!.cartsItems.forEach((element) {
          cartItemsQuantity.addAll({element.id: element.quantity});
          numberInCart += element.quantity;
        });
        emit(GetCartsSuccessState());
      } else {
        print('else block get carts error state');
        emit(GetCartsErrorState());
      }
    }).catchError((error) {
      print('catch block get carts error state');
      print(error.toString());
      emit(GetCartsErrorState(message: error.toString()));
    });
  }

//get profile data function
  void getProfileData() {
    DioHelper.getData(
      endPoint: PROFILE,
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      userModel = UserModel.fromMap(value.data);
      if (userModel!.status) {
        print('user name=${userModel!.data!.name}');
        emit(GetProfileSuccessState());
      } else {
        emit(GetProfileErrorState());
      }
    }).catchError((error) {
      print('catch block get carts error state');
      print(error.toString());
      emit(GetProfileErrorState());
    });
  }

  //add or delete product from favorite list
  void changeFavoriteProduct(int id) {
    favoritesModel = null;
    emit(AddDeleteFavoriteProductLoadingState());
    DioHelper.postData(
      endPoint: FAVORITE,
      language: CacheHelper.getData(key: 'lang').toString(),
      data: {'product_id': id},
    ).then((value) {
      if (value.data['status']) {
        emit(AddDeleteFavoriteProductSuccessState(
            message: value.data['message']));
        getFavoritesProducts();
      } else {
        favoritesList[id] = !favoritesList[id]!;
        emit(
            AddDeleteFavoriteProductErrorState(message: value.data['message']));
        // print('else block');
      }
    }).catchError((error) {
      favoritesList[id] = !favoritesList[id]!;
      //print(error.toString());
      emit(AddDeleteFavoriteProductErrorState());
    });
  }

  // add product to cart
  void addProductToCart(int productId) {
    emit(AddCartLoadingState());
    DioHelper.postData(
      endPoint: 'carts',
      data: {"product_id": productId},
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      if (value.data['status']) {
        getCarts();
        emit(AddCartSuccessState(message: value.data['message']));
      } else {
        emit(AddCartErrorState(message: value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(AddCartErrorState(message: error.toString()));
    });
  }

  // update quantity of product in cart
  void updateCart(int id, int quantity) {
    DioHelper.putData(
      endPoint: 'carts/$id',
      data: {
        'quantity': quantity,
      },
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      if (value.data['status']) {
        getCarts();
        emit(UpdateCartSuccessState());
      } else {
        getCarts();
        emit(UpdateCartErrorState(value.data['message']));
      }
    }).catchError((error) {
      getCarts();
      print(error.toString());
      emit(UpdateCartErrorState(error.toString()));
    });
  }

  // delete product from cart
  void deleteCart(int id) {
    DioHelper.deleteData(
      endPoint: 'carts/$id',
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      if (value.data['status']) {
        getCarts();
        emit(DeleteCartSuccessState());
      } else {
        emit(DeleteCartErrorState(value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(DeleteCartErrorState(error.toString()));
    });
  }

  // increase quantity
  void increaseQuantity(CartItem item) {
    cartItemsQuantity[item.id] = cartItemsQuantity[item.id]! + 1;
    emit(ChangeProductQuantityState());
  }

// decrease  quantity
  void decreaseQuantity(CartItem item) {
    if (cartItemsQuantity[item.id]! > 1) {
      cartItemsQuantity[item.id] = cartItemsQuantity[item.id]! - 1;
      emit(ChangeProductQuantityState());
    }
  }

  // add new address to add order
  void addAddress() {
    emit(AddAddressLoadingState());
    DioHelper.postData(
      endPoint: ADDRESSES,
      data: {
        "name": nameController.text,
        "city": selectedCity,
        "region": regionController.text,
        "notes": notesController.text,
        "details": detailsController.text,
        "latitude": 30.0616863,
        "longitude": 31.3260088,
      },
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      if (value.data['status']) {
        emit(AddAddressSuccessState());
        addOrder(id: value.data['data']['id']);
      } else {
        print(value.data['message']);
        emit(AddAddressErrorState(message: value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(AddAddressErrorState(message: error.toString()));
    });
  }

  //logout
  void logout() {
    numberInCart = 0;
    cartModel = null;
    favoritesModel = null;
    emit(LogoutLoadingState());
    DioHelper.postData(
      endPoint: LOGOUT,
      language: CacheHelper.getData(key: 'lang').toString(),
      data: {
        'fcm_token':
            'BHMM1zg9fzcDwcgIZtBuOfzWrRopQYB3kVaws0rkIa1vtIHmNk4ifXSJjuPZscrSFbhB47'
      },
    ).then((value) {
      if (value.data['status']) {
        CacheHelper.removeData(key: 'userToken');
        CacheHelper.removeData(key: 'userImage');
        CacheHelper.removeData(key: 'userName');
        CacheHelper.removeData(key: 'userEmail');
        getProducts();
        getHomeProducts();
        emit(LogoutSuccessState(message: value.data['message']));
      } else {
        emit(LogoutErrorState(message: value.data['message']));
        // print('else block');
      }
    }).catchError((error) {
      //print(error.toString());
      emit(LogoutErrorState());
    });
  }

// add order
  void addOrder({
    required int id,
    bool usePoints = false,
  }) {
    DioHelper.postData(
      endPoint: ORDERS,
      data: {
        "address_id": id,
        "payment_method": paymentWay == Payments.Cache ? 1 : 2,
        "use_points": usePoints,
      },
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      if (value.data['status']) {
        getCarts();
        emit(AddOrderSuccessState(message: value.data['message']));
      } else {
        emit(AddOrderErrorState(message: value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(AddOrderErrorState(message: error.toString()));
    });
  }
}
