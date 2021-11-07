import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/screens/add_to_cart/add_to_cart_screen.dart';
import 'package:e_commerce_app/shared/components/add_cart_button.dart';
import 'package:e_commerce_app/shared/components/discount_container.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';

class HorizontalProductItem extends StatelessWidget {
  ProductModel product;

  HorizontalProductItem({
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 130,
        //width: 130,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // product image
            Container(
              height: 120,
              width: 110,
              decoration: BoxDecoration(
                // color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(product.image),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // product details (name, discount , price)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // discount
                    if (product.discount > 0)
                      DiscountContainer(
                        text: product.discount.toString(),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    // name
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  color: appNormalColor,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
//product price
                    Row(
                      children: [
                        if (product.discount > 0)
                          Text(
                            product.oldPrice.toString(),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough),
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          product.price.toString(),
                          style: priceTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            // add cart button
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20, end: 10),
              child: AddCartButton(onPress: () {
                navigateTo(
                  context: context,
                  nextScreen: AddToCartScreen(product),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
