import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/screens/categories/category_product_screen.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Up To 40% Off Holiday Bit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Conditional.single(
                context: context,
                conditionBuilder: (context) => cubit.categoryModel != null,
                widgetBuilder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1 / 1.4,
                    children: List.generate(
                      cubit.categoryModel!.data!.categoriesList.length,
                      (index) {
                        return buildCategoryItem(
                          cubit.categoryModel!.data!.categoriesList[index],
                          context,
                        );
                      },
                    ),
                  ),
                ),
                fallbackBuilder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildCategoryItem(Category category, BuildContext context) {
  return GestureDetector(
    onTap: () {
      navigateTo(
        context: context,
        nextScreen: CategoryProductsScreen(category),
      );
      ShopCubit.get(context).getCategoryDetails(category.id);
    },
    child: Container(
      child: Stack(
        children: [
          Card(
            elevation: 3,
            color: Colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(category.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 25,
              color: Colors.blueGrey[100]!.withOpacity(.8),
              child: Center(
                  child: Text(
                category.name,
                style: priceTextStyle,
              )),
            ),
          ),
        ],
      ),
    ),
  );
}
