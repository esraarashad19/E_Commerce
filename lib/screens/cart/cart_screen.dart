import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/screens/checkout/checkout_screen.dart';
import 'package:e_commerce_app/shared/components/defualt_rectangle_button.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/components/show_message.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:e_commerce_app/models/carts_model.dart';

import '../../app_localization.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is GetCartsErrorState)
          showMessageBox(
            message: state.message!,
            context: context,
          );
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        if (CacheHelper.getData(key: 'userToken') == null)
          return Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sign In To Add Products into Cart',
                  style: notesTextStyle,
                ),
              ),
            ),
          );
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.cartModel != null,
          widgetBuilder: (context) {
            if (cubit.cartModel!.data != null &&
                cubit.cartModel!.data!.cartsItems.length > 0)
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => bulidCartItem(
                          cubit.cartModel!.data!.cartsItems[index],
                          context,
                        ),
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: Colors.grey[200],
                        ),
                        itemCount: cubit.cartModel!.data!.cartsItems.length,
                      ),
                      Column(
                        children: [
                          // sub total
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('SubTotal')!,
                                  style: priceTextStyle,
                                ),
                                Spacer(),
                                Text(
                                  '\$${cubit.cartModel!.data!.subTotal}',
                                  style: priceTextStyle,
                                ),
                              ],
                            ),
                          ),
                          // tax
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate('Tax')!,
                                style: priceTextStyle,
                              ),
                              Spacer(),
                              Text(
                                '\$0.00',
                                style: priceTextStyle,
                              ),
                            ],
                          ),
                          // total
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('Total')!,
                                  style: priceTextStyle,
                                ),
                                Spacer(),
                                Text(
                                  '\$${cubit.cartModel!.data!.total}',
                                  style: priceTextStyle,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DefualtRectangleButton(
                            onpress: () {
                              navigateTo(
                                context: context,
                                nextScreen: CheckoutScreen(),
                              );
                            },
                            title: 'Proceed to CheckOut',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );

            return Center(
              child: Container(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Cart is empty return to shop and add to favorite',
                      style: notesTextStyle,
                    ),
                  ),
                ),
              ),
            );
          },
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget bulidCartItem(CartItem item, BuildContext context) {
  var cubit = ShopCubit.get(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // product image
        Container(
          height: 130,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            image: DecorationImage(
              image: NetworkImage(
                item.product.image,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        // product name
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Text(
              item.product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: priceTextStyle,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${item.product.price.toString()}',
                style: priceTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 35,
                  width: 90,
                  color: Colors.grey[200],
                  // increase product quantity container
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // decrease button
                      InkWell(
                        onTap: () {
                          cubit.decreaseQuantity(item);
                          cubit.updateCart(
                              item.id, cubit.cartItemsQuantity[item.id]!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Icon(
                            Icons.minimize,
                            size: 18,
                          ),
                        ),
                      ),
                      // product quantity
                      Text(
                        cubit.cartItemsQuantity[item.id].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // increase button
                      InkWell(
                        onTap: () {
                          cubit.increaseQuantity(item);
                          cubit.updateCart(
                              item.id, cubit.cartItemsQuantity[item.id]!);
                        },
                        child: Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // delete cart button
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: appNormalColor,
                ),
                onPressed: () {
                  ShopCubit.get(context).deleteCart(item.id);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
