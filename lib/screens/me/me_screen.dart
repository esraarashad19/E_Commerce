import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/screens/app_setting/app_setting_screen.dart';
import 'package:e_commerce_app/screens/orders/orders_screen.dart';
import 'package:e_commerce_app/screens/user_signing/login/login_screen.dart';
import 'package:e_commerce_app/screens/user_signing/register/register_screen.dart';
import 'package:e_commerce_app/shared/components/add_cart_button.dart';
import 'package:e_commerce_app/shared/components/defualt_rectangle_button.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/components/defualt_list_tile.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app_localization.dart';

class MeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var local = AppLocalizations.of(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (CacheHelper.getData(key: 'userToken') == null)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              local!.translate(
                                'Sign in to receive exclusive offers and Promotions',
                              )!,
                              style: normalTextStyle,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Container(
                          height: 50,
                          child: Row(
                            children: [
                              Expanded(
                                child: DefualtRectangleButton(
                                  title: 'Sign in',
                                  onpress: () {
                                    cubit.changeCurrentIndex(0);
                                    navigateTo(
                                      context: context,
                                      nextScreen: LoginScreen(),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: DefualtRectangleButton(
                                  title: 'Create Account',
                                  onpress: () {
                                    cubit.changeCurrentIndex(0);
                                    navigateTo(
                                      context: context,
                                      nextScreen: RegisterScreen(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                if (CacheHelper.getData(key: 'userName') != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                    CacheHelper.getData(key: 'userImage'),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      local!.translate('Welcome')!,
                                      style: normalTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      CacheHelper.getData(key: 'userName'),
                                      style: titleTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          local.translate(
                            'Information',
                          )!,
                          style: titleTextStyle,
                        ),
                      ),
                      // my account listTile
                      DefualtListTile(
                        onPress: () {},
                        leadIcon: Icons.account_circle_outlined,
                        title: 'My Account',
                      ),
                      // app setting listTile
                      DefualtListTile(
                        onPress: () {
                          navigateTo(
                            context: context,
                            nextScreen: OrdersScreen(),
                          );
                        },
                        leadIcon: Icons.all_inbox_outlined,
                        title: 'Order & Return',
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    local!.translate(
                      'Setting',
                    )!,
                    style: titleTextStyle,
                  ),
                ),
                // app setting listTile
                DefualtListTile(
                  onPress: () {
                    navigateTo(
                      context: context,
                      nextScreen: AppSettingScreen(),
                    );
                  },
                  leadIcon: Icons.settings_outlined,
                  title: 'App Setting',
                ),
                // help & info listTile
                DefualtListTile(
                  onPress: () {},
                  leadIcon: Icons.info_outline_rounded,
                  title: 'Help & Info',
                ),
                // hotline listTile
                DefualtListTile(
                  onPress: () {},
                  leadIcon: Icons.phone_forwarded_outlined,
                  subTitle: '01551311245',
                  title: 'Hotline',
                ),
                // log out listTile
                if (CacheHelper.getData(key: 'userToken') != null &&
                    state is! LogoutLoadingState)
                  DefualtListTile(
                    onPress: () {
                      cubit.logout();
                    },
                    leadIcon: Icons.logout,
                    title: 'Sign Out',
                  ),
                if (state is LogoutLoadingState)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'shop 2020',
                      style: normalTextStyle,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 16),
                      child: AddCartButton(
                        onPress: () {},
                        color: Colors.white,
                        iconColor: Colors.blue,
                        icon: FontAwesomeIcons.facebookSquare,
                        iconSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 16),
                      child: AddCartButton(
                        onPress: () {},
                        color: Colors.white,
                        iconColor: Colors.deepOrange,
                        icon: FontAwesomeIcons.googlePlusG,
                        iconSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 16),
                      child: AddCartButton(
                        onPress: () {},
                        color: Colors.white,
                        iconColor: Colors.blue,
                        icon: FontAwesomeIcons.twitter,
                        iconSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 16),
                      child: AddCartButton(
                        onPress: () {},
                        color: Colors.white,
                        iconColor: Colors.green,
                        icon: FontAwesomeIcons.phone,
                        iconSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
