import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/screens/add_to_cart/add_to_cart_screen.dart';
import 'package:e_commerce_app/shared/components/add_cart_button.dart';
import 'package:e_commerce_app/shared/components/discount_container.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:flutter/material.dart';

class BuildProductItem extends StatelessWidget {
  ProductModel product;
  double height;
  BuildProductItem({
    required this.product,
    this.height = 180,
  });
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //product image and add cart button
        Stack(
          children: [
            //product image
            Card(
              elevation: 1,
              child: Column(
                children: [
                  // row of favorite button and discount container
                  Row(
                    children: [
                      if (product.discount > 0)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 8),
                          child: DiscountContainer(
                            text: product.discount.toString(),
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          cubit.favoritesList[product.id]!
                              ? Icons.favorite_outlined
                              : Icons.favorite_border,
                          size: 20,
                        ),
                        onPressed: () {
                          cubit.favoritesList[product.id] =
                              !cubit.favoritesList[product.id]!;
                          cubit.changeFavoriteProduct(product.id);
                        },
                      ),
                    ],
                  ),
                  // product image container
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      //color: Colors.grey[100],
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // add cart button
            Positioned(
              bottom: 10,
              right: 10,
              child: AddCartButton(
                onPress: () {
                  navigateTo(
                    context: context,
                    nextScreen: AddToCartScreen(product),
                  );
                },
              ),
            ),
          ],
        ),
        // product name
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // product Price
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: Row(
            children: [
              if (product.discount > 0)
                Text(
                  product.oldPrice.toString(),
                  style: TextStyle(
                    color: Colors.blueGrey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              if (product.discount > 0)
                SizedBox(
                  width: 5,
                ),
              Text(
                product.price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
