abstract class ShopStates {}

class InitialShopState extends ShopStates {}

// layout states
class ChangeNavigationBarShopState extends ShopStates {}

// home Screen States
class GetHomeProductsLoadingState extends ShopStates {}

class GetHomeProductsSuccessState extends ShopStates {}

class GetHomeProductsErrorState extends ShopStates {
  String? message;
  GetHomeProductsErrorState({this.message});
}

// get products States

class GetProductsSuccessState extends ShopStates {}

class GetProductsErrorState extends ShopStates {
  String? message;
  GetProductsErrorState({this.message});
}

// Categories Screen States
class GetCategoriesLoadingState extends ShopStates {}

class GetCategoriesSuccessState extends ShopStates {}

class GetCategoriesErrorState extends ShopStates {
  String? message;
  GetCategoriesErrorState({this.message});
}

//get product in category
class GetCategoryDetailsLoadingState extends ShopStates {}

class GetCategoryDetailsSuccessState extends ShopStates {}

class GetCategoryDetailsErrorState extends ShopStates {
  String? message;
  GetCategoryDetailsErrorState({this.message});
}

// change favorites products states
class AddDeleteFavoriteProductLoadingState extends ShopStates {
  AddDeleteFavoriteProductLoadingState();
}

class AddDeleteFavoriteProductSuccessState extends ShopStates {
  String? message;
  AddDeleteFavoriteProductSuccessState({this.message});
}

class AddDeleteFavoriteProductErrorState extends ShopStates {
  String? message;
  AddDeleteFavoriteProductErrorState({this.message});
}

//get profile states

class GetProfileSuccessState extends ShopStates {}

class GetProfileErrorState extends ShopStates {
  String? message;
  GetProfileErrorState({this.message});
}

//get favorites screen states
class GetFavoritesLoadingState extends ShopStates {}

class GetFavoritesSuccessState extends ShopStates {}

class GetFavoritesErrorState extends ShopStates {
  String? message;
  GetFavoritesErrorState({this.message});
}

//get Carts screen states
class GetCartsLoadingState extends ShopStates {}

class GetCartsSuccessState extends ShopStates {}

class GetCartsErrorState extends ShopStates {
  String? message;
  GetCartsErrorState({this.message});
}

// update cart states
class UpdateCartSuccessState extends ShopStates {}

class UpdateCartErrorState extends ShopStates {
  String? message;
  UpdateCartErrorState(this.message);
}

// Delete cart states
class DeleteCartSuccessState extends ShopStates {}

class DeleteCartErrorState extends ShopStates {
  String? message;
  DeleteCartErrorState(this.message);
}

// AddCart products states
class AddCartLoadingState extends ShopStates {}

class AddCartSuccessState extends ShopStates {
  String? message;
  AddCartSuccessState({this.message});
}

class AddCartErrorState extends ShopStates {
  String? message;
  AddCartErrorState({this.message});
}

// search products states
class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {}

class SearchErrorState extends ShopStates {
  String? message;
  SearchErrorState({this.message});
}

// Logout states
class LogoutLoadingState extends ShopStates {}

class LogoutSuccessState extends ShopStates {
  String? message;
  LogoutSuccessState({this.message});
}

class LogoutErrorState extends ShopStates {
  String? message;
  LogoutErrorState({this.message});
}

// Add new Address State
class AddAddressLoadingState extends ShopStates {}

class AddAddressSuccessState extends ShopStates {}

class AddAddressErrorState extends ShopStates {
  String? message;
  AddAddressErrorState({this.message});
}

// Add order State
class AddOrderLoadingState extends ShopStates {}

class AddOrderSuccessState extends ShopStates {
  String? message;
  AddOrderSuccessState({this.message});
}

class AddOrderErrorState extends ShopStates {
  String? message;
  AddOrderErrorState({this.message});
}

class ChangeProductQuantityState extends ShopStates {}

class ChangeLanguageState extends ShopStates {}

class ChangeAppThemeState extends ShopStates {}

class ChangeCurrentViewState extends ShopStates {}

class ChangeCityState extends ShopStates {}

class ChangePaymentState extends ShopStates {}
