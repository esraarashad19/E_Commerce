import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:flutter/material.dart';

class DefualtCartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ShopCubit.get(context).changeCurrentIndex(3);
        navigateTo(context: context, nextScreen: MainLayout());
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 8.0),
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  ShopCubit.get(context).numberInCart.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              Icon(
                Icons.shopping_cart_outlined,
                size: 28,
              )
            ],
          ),
          // onPressed: () {},
        ),
      ),
    );
  }
}
