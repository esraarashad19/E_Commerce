abstract class OrdersDetailsStates {}

class InitialOrdersDetailsState extends OrdersDetailsStates {}

// get borders states
class GetOrdersDetailsLoadingState extends OrdersDetailsStates {}

class GetOrdersDetailsSuccessState extends OrdersDetailsStates {}

class GetOrdersDetailsErrorState extends OrdersDetailsStates {
  String? message;
  GetOrdersDetailsErrorState({this.message});
}

// cancel order states
class CancelOrderLoadingState extends OrdersDetailsStates {}

class CancelOrderSuccessState extends OrdersDetailsStates {
  String? message;
  CancelOrderSuccessState({this.message});
}

class CancelOrderErrorState extends OrdersDetailsStates {
  String? message;
  CancelOrderErrorState({this.message});
}
