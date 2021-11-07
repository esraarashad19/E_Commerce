import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/shared/components/defualt_cart_icon.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/components/show_message.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_localization.dart';

class AddToCartScreen extends StatefulWidget {
  ProductModel product;
  AddToCartScreen(this.product);

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  double offset = 0;
  @override
  Widget build(BuildContext context) {
    var imageHeight = MediaQuery.of(context).size.height / 2.5;
    var screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is AddCartSuccessState)
          showToast(msg: state.message!, backColor: Colors.green);
        if (state is AddCartErrorState)
          showToast(msg: state.message!, backColor: Colors.red);
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefualtCartIcon(),
                  ),
                ),
              ),
            ],
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              setState(() {
                offset = notification.metrics.pixels;
              });
              return true;
            },
            child: Stack(
              children: [
                Positioned(
                  top: -10 * offset,
                  child: Container(
                    height: imageHeight,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(widget.product.image),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: imageHeight,
                      ),
                      Container(
                        width: screenWidth,
                        color: Colors.grey[100],
                        height: imageHeight * 8,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //product name
                              Container(
                                width: screenWidth / 2,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.product.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // product price
                              Row(
                                children: [
                                  if (widget.product.discount > 0)
                                    Text(
                                      widget.product.oldPrice.toString(),
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  if (widget.product.discount > 0)
                                    SizedBox(
                                      width: 5,
                                    ),
                                  Text(
                                    widget.product.price.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Spacer(),
                                  if (cubit.inCartList[widget.product.id]!)
                                    Text(
                                      AppLocalizations.of(context)!
                                          .translate('In Cart')!,
                                      style: TextStyle(color: Colors.green),
                                    ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 10),
                                child: Text(
                                  widget.product.description,
                                  style: TextStyle(
                                    color: appNormalColor,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home_outlined,
                    color: appNormalColor,
                  ),
                  onPressed: () {
                    cubit.changeCurrentIndex(0);
                    navigateAndFinish(
                        context: context, nextScreen: MainLayout());
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.search_outlined,
                    color: appNormalColor,
                  ),
                  onPressed: () {
                    cubit.changeCurrentIndex(1);
                    navigateTo(context: context, nextScreen: MainLayout());
                  },
                ),
                SizedBox(
                  width: 100,
                ),
                IconButton(
                  icon: Icon(
                    cubit.favoritesList[widget.product.id]!
                        ? Icons.favorite_outlined
                        : Icons.favorite_border,
                    color: appNormalColor,
                  ),
                  onPressed: () {
                    cubit.favoritesList[widget.product.id] =
                        !cubit.favoritesList[widget.product.id]!;
                    cubit.changeFavoriteProduct(widget.product.id);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: appNormalColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
          ),
          floatingActionButton: state is! AddCartLoadingState
              ? FloatingActionButton(
                  onPressed: () {
                    cubit.addProductToCart(widget.product.id);
                    cubit.inCartList[widget.product.id] =
                        !cubit.inCartList[widget.product.id]!;
                  },
                  child: Icon(
                    Icons.shopping_cart,
                  ),
                )
              : CircularProgressIndicator(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
        );
      },
    );
  }
}
