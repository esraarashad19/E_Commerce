import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/shared/components/defualt_app_bar.dart';
import 'package:e_commerce_app/shared/components/build_product_item.dart';
import 'package:e_commerce_app/shared/components/defualt_cart_icon.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:e_commerce_app/shared/components/horizontal_product_item.dart';

class CategoryProductsScreen extends StatelessWidget {
  Category category;
  CategoryProductsScreen(this.category);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: defualtAppBar(
              context: context,
              titleWidget: Column(
                children: [
                  Text(
                    category.name,
                    style: titleTextStyle,
                  ),
                ],
              ),
              actionWidget: DefualtCartIcon(),
              onLeadPress: () {
                Navigator.pop(context);
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.sort,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Sort',
                                style: normalTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.border_all_outlined,
                            color: cubit.currentViewIndex == 0
                                ? Colors.blue
                                : appNormalColor,
                          ),
                          onPressed: () {
                            cubit.changeCurrentViewIndex(0);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.check_box_outline_blank,
                            color: cubit.currentViewIndex == 1
                                ? Colors.blue
                                : appNormalColor,
                          ),
                          onPressed: () {
                            cubit.changeCurrentViewIndex(1);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.format_list_bulleted,
                            color: cubit.currentViewIndex == 2
                                ? Colors.blue
                                : appNormalColor,
                          ),
                          onPressed: () {
                            cubit.changeCurrentViewIndex(2);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        cubit.categoryProductsModel != null,
                    widgetBuilder: (context) {
                      if (state is GetCategoryDetailsLoadingState)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      // change display view(list/full screen/ horizontal)
                      return Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            cubit.currentViewIndex == 0 ||
                            cubit.currentViewIndex == 1,
                        widgetBuilder: (context) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.count(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: cubit.currentViewIndex == 0 ? 2 : 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 2,
                            childAspectRatio: cubit.currentViewIndex == 0
                                ? 1 / 1.9
                                : 1 / 1.15,
                            children: List.generate(
                              cubit.categoryProductsModel!.data!
                                  .categoryProducts.length,
                              (index) {
                                return BuildProductItem(
                                  product: cubit.categoryProductsModel!.data!
                                      .categoryProducts[index],
                                  height:
                                      cubit.currentViewIndex == 1 ? 250 : 180,
                                );
                              },
                            ),
                          ),
                        ),
                        fallbackBuilder: (context) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                HorizontalProductItem(
                              product: cubit.categoryProductsModel!.data!
                                  .categoryProducts[index],
                            ),
                            separatorBuilder: (context, index) => Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            itemCount: cubit.categoryProductsModel!.data!
                                .categoryProducts.length,
                          ),
                        ),
                      );
                    },
                    fallbackBuilder: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
