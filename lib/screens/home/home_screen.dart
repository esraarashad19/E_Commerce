import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/screens/categories/category_product_screen.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/shared/components/build_product_item.dart';
import '../../app_localization.dart';

class HomeScreen extends StatelessWidget {
  var boardController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              cubit.homeModel != null && cubit.categoryModel != null,
          widgetBuilder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // banners
                CarouselSlider(
                  items: cubit.homeModel!.data!.banners
                      .map((e) => Image(
                            image: NetworkImage(e.image),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    initialPage: 0,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // categories headLines and showall text button
                      Row(
                        children: [
                          // categories headLines
                          Text(
                            AppLocalizations.of(context)!
                                .translate('Categories')!,
                            style: mainTitleTextStyle,
                          ),
                          Spacer(),
                          //showall text button
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('show all')!,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 160,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildCategoryItem(
                              cubit.categoryModel!.data!.categoriesList[index],
                              context),
                          separatorBuilder: (context, index) => Container(
                            width: 5,
                          ),
                          itemCount:
                              cubit.categoryModel!.data!.categoriesList.length,
                        ),
                      ),
                      // product text
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          AppLocalizations.of(context)!.translate('Products')!,
                          style: mainTitleTextStyle,
                        ),
                      ),
                      GridView.count(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 35,
                        crossAxisSpacing: 2,
                        childAspectRatio: 1 / 1.9,
                        children: List.generate(
                          cubit.homeModel!.data!.products.length,
                          (index) {
                            return BuildProductItem(
                              product: cubit.homeModel!.data!.products[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          fallbackBuilder: (context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildCategoryItem(category, context) {
  return GestureDetector(
    onTap: () {
      navigateTo(
        context: context,
        nextScreen: CategoryProductsScreen(category),
      );
      ShopCubit.get(context).getCategoryDetails(category.id);
    },
    child: Column(
      children: [
        Container(
          width: 130,
          height: 130,
          child: Card(
            //color: Colors.grey,
            elevation: 2,
            child: Image(
              image: NetworkImage(category.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: Text(
            category.name,
            style: titleTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
