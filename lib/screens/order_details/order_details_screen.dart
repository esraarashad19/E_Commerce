import 'package:e_commerce_app/app_localization.dart';
import 'package:e_commerce_app/screens/order_details/cubit/cubit.dart';
import 'package:e_commerce_app/screens/order_details/cubit/states.dart';
import 'package:e_commerce_app/screens/orders/cubit/cubit.dart';
import 'package:e_commerce_app/screens/orders/cubit/states.dart';
import 'package:e_commerce_app/shared/components/defualt_app_bar.dart';
import 'package:e_commerce_app/shared/components/defualt_rectangle_button.dart';
import 'package:e_commerce_app/shared/components/show_message.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class OrderDetailsScreen extends StatelessWidget {
  int orderId;
  OrderDetailsScreen(this.orderId);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersDetailsCubit()..getOrdersDetails(orderId),
      child: BlocConsumer<OrdersDetailsCubit, OrdersDetailsStates>(
        listener: (context, state) {
          if (state is CancelOrderSuccessState)
            showToast(msg: state.message!, backColor: Colors.green);
          if (state is CancelOrderErrorState)
            showToast(msg: state.message!, backColor: Colors.red);
        },
        builder: (context, state) {
          var local = AppLocalizations.of(context)!;
          var cubit = OrdersDetailsCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: defualtAppBar(
              context: context,
              titleWidget: Text(
                local.translate('Order Details')!,
                style: titleTextStyle,
              ),
              onLeadPress: () {
                Navigator.pop(context);
              },
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) => cubit.orderModel != null,
              widgetBuilder: (context) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            local.translate('Your Products')!,
                            style: mainTitleTextStyle,
                          ),
                        ),
                        Card(
                          color: Colors.blueGrey[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              cubit.orderModel!.data!
                                                  .products[index].image,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.orderModel!.data!
                                                  .products[index].name,
                                              style: priceTextStyle,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              'x${cubit.orderModel!.data!.products[index].quantity}',
                                              style: priceTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemCount: cubit.orderModel!.data!.products.length,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            local.translate('Your Address')!,
                            style: mainTitleTextStyle,
                          ),
                        ),
                        Card(
                          color: Colors.blueGrey[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                buildAddressRow(
                                  key: 'Name',
                                  value: cubit.orderModel!.data!.address.name,
                                  context: context,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                buildAddressRow(
                                  key: 'City',
                                  value: cubit.orderModel!.data!.address.city,
                                  context: context,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                buildAddressRow(
                                  key: 'Region',
                                  value: cubit.orderModel!.data!.address.region,
                                  context: context,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                buildAddressRow(
                                  key: 'Details',
                                  value:
                                      cubit.orderModel!.data!.address.details,
                                  context: context,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                buildAddressRow(
                                  key: 'Order Notes',
                                  value: cubit.orderModel!.data!.address
                                              .notes !=
                                          null
                                      ? cubit.orderModel!.data!.address.notes!
                                      : '......',
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            local.translate('Order Details')!,
                            style: mainTitleTextStyle,
                          ),
                        ),
                        Card(
                          color: Colors.blueGrey[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                buildAddressRow(
                                  key: 'Total',
                                  value: '${cubit.orderModel!.data!.total}\$',
                                  context: context,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                buildAddressRow(
                                  key: 'Payment',
                                  value: cubit.orderModel!.data!.payment,
                                  context: context,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                buildAddressRow(
                                  key: 'Date',
                                  value: cubit.orderModel!.data!.date,
                                  context: context,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (state is! CancelOrderLoadingState)
                          BlocConsumer<OrdersCubit, OrdersStates>(
                            builder: (context, state) => DefualtRectangleButton(
                              onpress: () {
                                cubit.cancelOrders(
                                  orderId,
                                );
                                OrdersCubit.get(context).getOrders();
                              },
                              title: 'Cancel Order',
                            ),
                            listener: (context, state) {},
                          ),
                        if (state is CancelOrderLoadingState)
                          Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                );
              },
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

Widget buildAddressRow({
  required String key,
  required String value,
  required BuildContext context,
}) {
  return Row(
    children: [
      Container(
        width: 60,
        child: Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.translate(key)!,
                style: priceTextStyle.copyWith(color: Colors.blue),
              ),
            ),
            Text(
              ':',
              style: priceTextStyle.copyWith(color: Colors.blue),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Text(
        value,
        style: priceTextStyle,
      ),
    ],
  );
}
