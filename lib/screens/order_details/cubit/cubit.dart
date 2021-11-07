import 'package:e_commerce_app/models/order_details_model.dart';
import 'package:e_commerce_app/screens/order_details/cubit/states.dart';
import 'package:e_commerce_app/screens/orders/cubit/cubit.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:e_commerce_app/shared/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersDetailsCubit extends Cubit<OrdersDetailsStates> {
  OrdersDetailsCubit() : super(InitialOrdersDetailsState());
  static OrdersDetailsCubit get(context) => BlocProvider.of(context);

  OrderDetailsModel? orderModel;

  // get orders
  void getOrdersDetails(int id) {
    emit(GetOrdersDetailsLoadingState());
    DioHelper.getData(
      endPoint: 'orders/$id',
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      orderModel = OrderDetailsModel.fromMap(value.data);
      if (orderModel!.status) {
        print('products in order=${orderModel!.data!.products.length}');
        emit(GetOrdersDetailsSuccessState());
      } else {
        emit(GetOrdersDetailsErrorState(message: orderModel!.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetOrdersDetailsErrorState(message: orderModel!.message));
    });
  }

  // get orders
  void cancelOrders(int id) {
    emit(CancelOrderLoadingState());
    DioHelper.getData(
      endPoint: 'orders/$id/cancel',
      language: CacheHelper.getData(key: 'lang').toString(),
    ).then((value) {
      if (value.data['status']) {
        emit(CancelOrderSuccessState(message: value.data['message']));
      } else {
        emit(CancelOrderErrorState(message: value.data['message']));
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetOrdersDetailsErrorState(message: error.toString()));
    });
  }
}
