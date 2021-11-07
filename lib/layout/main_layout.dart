import 'package:e_commerce_app/app_localization.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/screens/drawer/drawer_screen.dart';
import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/me/me_screen.dart';
import 'package:e_commerce_app/screens/search/search_screen.dart';
import 'package:e_commerce_app/screens/shop/shop_screen.dart';
import 'package:e_commerce_app/screens/wishlist/wishlist_screen.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/shared/components/defualt_app_bar.dart';
import 'package:e_commerce_app/shared/components/defualt_cart_icon.dart';

class MainLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> screens = [
    HomeScreen(),
    ShopScreen(),
    WishlistScreen(),
    CartScreen(),
    MeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    var local = AppLocalizations.of(context);
    List<PreferredSizeWidget> appbars = [
      //home app bar
      defualtAppBar(
        isHome: true,
        titleWidget: Text(
          'Shop',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        actionWidget: DefualtCartIcon(),
        context: context,
      ),
      //shop appbar
      defualtAppBar(
        isSearch: true,
        titleWidget: Padding(
          padding: const EdgeInsetsDirectional.only(
            end: 20,
          ),
          child: GestureDetector(
            onTap: () {
              navigateTo(
                context: context,
                nextScreen: SearchScreen(),
              );
            },
            child: Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        BorderSide(width: .5, color: Colors.blueGrey[100]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        BorderSide(width: .5, color: Colors.blueGrey[100]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        BorderSide(width: .5, color: Colors.blueGrey[100]!),
                  ),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                  ),
                  hintText: AppLocalizations.of(context)!
                      .translate('Search Products')!,
                  helperStyle: TextStyle(
                    color: appNormalColor,
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                enabled: false,
              ),
            ),
          ),
        ),
        actionWidget: DefualtCartIcon(),
        context: context,
      ),
      // wishlist appbar
      defualtAppBar(
        titleWidget: Column(
          children: [
            Text(
              local!.translate('WishList')!,
              style: titleTextStyle,
            ),
            if (cubit.favoritesModel != null &&
                cubit.favoritesModel!.data != null)
              Text(
                '${cubit.favoritesModel!.data!.wishList.length} items',
                style: TextStyle(color: appNormalColor, fontSize: 14),
              ),
          ],
        ),
        actionWidget: DefualtCartIcon(),
        context: context,
      ),
      // cart app bar
      defualtAppBar(
        titleWidget: Text(
          cubit.cartModel != null && cubit.cartModel!.data != null
              ? 'Cart(${cubit.cartsNumber})'
              : 'Cart(0)',
          style: titleTextStyle,
        ),
        context: context,
      ),
      // me app bar
      defualtAppBar(
        titleWidget: Text(
          'Profile',
          style: titleTextStyle,
        ),
        actionWidget: Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        context: context,
      ),
    ];
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: appbars[cubit.currentIndex],
          drawer: Drawer(
            child: DrawerScreen(),
          ),
          body: screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeCurrentIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            unselectedIconTheme: IconThemeData(
              color: appNormalColor,
            ),
            unselectedLabelStyle: TextStyle(
              color: appNormalColor,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: AppLocalizations.of(context)!.translate('Home')!,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: AppLocalizations.of(context)!.translate('Shop')!,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: AppLocalizations.of(context)!.translate('WishList')!,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: AppLocalizations.of(context)!.translate('Cart')!,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: AppLocalizations.of(context)!.translate('Me')!,
              ),
            ],
          ),
        );
      },
    );
  }
}
