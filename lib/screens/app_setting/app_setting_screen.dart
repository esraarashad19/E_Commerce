import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/shared/components/defualt_app_bar.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/shared/components/defualt_list_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_localization.dart';

class AppSettingScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: defualtAppBar(
            context: context,
            onLeadPress: () {
              Navigator.pop(context);
            },
            titleWidget: Text(
              AppLocalizations.of(context)!.translate('App Setting')!,
              style: titleTextStyle,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DefualtListTile(
                  title: 'Language',
                  isTrailing: false,
                  subTitle: ShopCubit.get(context).selectedLanguage,
                  onPress: () {
                    scaffoldKey.currentState!.showBottomSheet((context) {
                      return Card(
                        elevation: 3,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                DefualtListTile(
                                  onPress: () {
                                    cubit.changeLanguage('en');
                                    Navigator.pop(context);
                                  },
                                  title: 'English',
                                  trailIcon: Icons.check,
                                  isTrailing: CacheHelper.getData(key: 'lang')
                                              .toString() ==
                                          'en'
                                      ? true
                                      : false,
                                  isSelected: CacheHelper.getData(key: 'lang')
                                              .toString() ==
                                          'en'
                                      ? true
                                      : false,
                                ),
                                DefualtListTile(
                                  onPress: () {
                                    cubit.changeLanguage('ar');
                                    Navigator.pop(context);
                                  },
                                  title: 'العربيه',
                                  trailIcon: Icons.check,
                                  isTrailing: CacheHelper.getData(key: 'lang')
                                              .toString() ==
                                          'ar'
                                      ? true
                                      : false,
                                  isSelected: CacheHelper.getData(key: 'lang')
                                              .toString() ==
                                          'ar'
                                      ? true
                                      : false,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('Dark Mode')!,
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        activeColor: Colors.blue,
                        value: ShopCubit.get(context).isDark,
                        onChanged: (value) {
                          ShopCubit.get(context).changeTheme(value);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.blueGrey[100],
                ),

                // CupertinoSwitch(value: value, onChanged: onChanged)
              ],
            ),
          ),
        );
      },
    );
  }
}
