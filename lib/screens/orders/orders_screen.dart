import 'package:e_commerce_app/app_localization.dart';
import 'package:e_commerce_app/screens/order_details/order_details_screen.dart';
import 'package:e_commerce_app/screens/orders/cubit/cubit.dart';
import 'package:e_commerce_app/screens/orders/cubit/states.dart';
import 'package:e_commerce_app/shared/components/defualt_app_bar.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var local = AppLocalizations.of(context)!;
        var cubit = OrdersCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: defualtAppBar(
            context: context,
            titleWidget: Text(
              local.translate('Orders')!,
              style: titleTextStyle,
            ),
            onLeadPress: () {
              Navigator.pop(context);
            },
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.ordersModel != null,
            widgetBuilder: (context) {
              if (cubit.ordersModel!.data!.orders.length == 0)
                return Center(
                  child: Container(
                    child: Text(
                      local.translate('No Orders Exists')!,
                      style: normalTextStyle,
                    ),
                  ),
                );
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        navigateTo(
                          context: context,
                          nextScreen: OrderDetailsScreen(
                            cubit.ordersModel!.data!.orders[index].id,
                          ),
                        );
                      },
                      leading: Text(
                        cubit.ordersModel!.data!.orders[index].status,
                        style: TextStyle(color: Colors.blue),
                      ),
                      title: Text(
                        cubit.ordersModel!.data!.orders[index].date,
                        style: normalTextStyle,
                      ),
                      subtitle: Text(
                        '\$${cubit.ordersModel!.data!.orders[index].total.round()}',
                        style: priceTextStyle,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: appNormalColor,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                  itemCount: cubit.ordersModel!.data!.orders.length,
                ),
              );
            },
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
