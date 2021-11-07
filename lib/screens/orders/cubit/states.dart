abstract class OrdersStates {}

class InitialOrdersState extends OrdersStates {}

// get borders states
class GetOrdersLoadingState extends OrdersStates {}

class GetOrdersSuccessState extends OrdersStates {}

class GetOrdersErrorState extends OrdersStates {
  String? message;
  GetOrdersErrorState({this.message});
}
