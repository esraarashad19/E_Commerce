import 'package:e_commerce_app/models/orders_model.dart';
import 'package:e_commerce_app/screens/orders/cubit/states.dart';
import 'package:e_commerce_app/shared/end_points.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:e_commerce_app/shared/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(InitialOrdersState());
  static OrdersCubit get(context) => BlocProvider.of(context);

  OrdersModel? ordersModel;

  // get orders
  void getOrders() {
    emit(GetOrdersLoadingState());
    DioHelper.getData(
      endPoint: ORDERS,
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      ordersModel = OrdersModel.fromMap(value.data);
      if (ordersModel!.status) {
        print('categories=${ordersModel!.data!.orders.length}');
        emit(GetOrdersSuccessState());
      } else {
        emit(GetOrdersErrorState(message: ordersModel!.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetOrdersErrorState(message: ordersModel!.message));
    });
  }
}
