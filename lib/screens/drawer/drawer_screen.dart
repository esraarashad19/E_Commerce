import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/screens/categories/category_product_screen.dart';
import 'package:e_commerce_app/screens/user_signing/login/login_screen.dart';
import 'package:e_commerce_app/screens/user_signing/register/register_screen.dart';
import 'package:e_commerce_app/shared/components/defualt_list_tile.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_localization.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        UserModel? model = CacheHelper.getData(key: 'user');
        var local = AppLocalizations.of(context)!;
        var cubit = ShopCubit.get(context);
        return ListView(
          children: [
            // user information
            UserAccountsDrawerHeader(
              accountName: Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: Text(
                  CacheHelper.getData(key: 'userName') != null
                      ? CacheHelper.getData(key: 'userName')
                      : local.translate('Guest')!,
                ),
              ),
              accountEmail: Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: Text(
                  CacheHelper.getData(key: 'userEmail') != null
                      ? CacheHelper.getData(key: 'userEmail')
                      : local.translate('Guest information')!,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: CacheHelper.getData(key: 'userImage') != null
                    ? NetworkImage(CacheHelper.getData(key: 'userImage'))
                    : NetworkImage(
                        'https://ih1.redbubble.net/image.1046392278.3346/aps,504x498,small,transparent-pad,600x600,f8f8f8.jpg'),
              ),
            ),
            // sign in/up text buttons
            if (CacheHelper.getData(key: 'userToken') == null)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: GestureDetector(
                  onTap: () {
                    navigateTo(
                      context: context,
                      nextScreen: LoginScreen(),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.login),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          navigateTo(
                            context: context,
                            nextScreen: LoginScreen(),
                          );
                        },
                        child: Text(
                          local.translate('Sign in')!,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text('/'),
                      TextButton(
                        onPressed: () {
                          navigateTo(
                            context: context,
                            nextScreen: RegisterScreen(),
                          );
                        },
                        child: Text(
                          local.translate('Sign up')!,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // categories text
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                local.translate('Categories')!,
                style: mainTitleTextStyle,
              ),
            ),
            if (cubit.categoryModel != null)
              ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Category category =
                        cubit.categoryModel!.data!.categoriesList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(category.image),
                      ),
                      title: Text(
                        category.name,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                        size: 15,
                      ),
                      minVerticalPadding: 20,
                      onTap: () {
                        navigateTo(
                          context: context,
                          nextScreen: CategoryProductsScreen(category),
                        );
                        cubit.getCategoryDetails(category.id);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 1,
                          color: Colors.grey[200],
                        ),
                      ),
                  itemCount: cubit.categoryModel!.data!.categoriesList.length)
          ],
        );
      },
    );
  }
}
