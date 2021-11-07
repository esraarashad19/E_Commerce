import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/shared/components/defualt_app_bar.dart';
import 'package:e_commerce_app/shared/components/horizontal_product_item.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Product',
                hintStyle: normalTextStyle,
                enabled: true,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (String value) {
                cubit.searchProducts(text: value);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                },
              ),
            ],
            iconTheme: IconThemeData(
              color: Colors.grey,
            ),
            centerTitle: true,
          ),
          body: Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.searchModel != null,
            widgetBuilder: (context) {
              if (state is SearchLoadingState)
                return Center(
                  child: CircularProgressIndicator(),
                );
              if (state is SearchSuccessState &&
                  cubit.searchModel!.data!.searchResultList.length == 0)
                return Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'No Result ',
                        style: notesTextStyle,
                      ),
                    ),
                  ),
                );
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => HorizontalProductItem(
                    product: cubit.searchModel!.data!.searchResultList[index],
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  itemCount: cubit.searchModel!.data!.searchResultList.length,
                ),
              );
            },
            fallbackBuilder: (context) => Container(),
          ),
        );
      },
    );
  }
}
