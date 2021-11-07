import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/shared/components/horizontal_product_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        if (CacheHelper.getData(key: 'userToken') == null)
          return Center(
            child: Container(
              child: Text(
                'Sign In To Add Products into WishList',
                style: notesTextStyle,
              ),
            ),
          );
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.favoritesModel != null,
          widgetBuilder: (context) {
            if (cubit.favoritesModel!.data != null &&
                cubit.favoritesModel!.data!.wishList.length > 0)
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => HorizontalProductItem(
                    product: cubit.favoritesModel!.data!.wishList[index],
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  itemCount: cubit.favoritesModel!.data!.wishList.length,
                ),
              );

            return Center(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'There is no products in favorites return to shop and add to favorite',
                    style: notesTextStyle,
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
