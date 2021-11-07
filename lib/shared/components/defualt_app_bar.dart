import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget defualtAppBar({
  Widget? titleWidget,
  Widget? actionWidget,
  Widget? leadWidget,
  int? currentScreenIndex,
  bool isSearch = false,
  bool isHome = false,
  var onLeadPress,
  required BuildContext context,
}) =>
    AppBar(
      elevation: 0,
      leadingWidth: isSearch ? 0 : null,
      backgroundColor: Colors.white,
      leading: !isHome
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
              onPressed: onLeadPress == null
                  ? () {
                      ShopCubit.get(context).changeCurrentIndex(
                          ShopCubit.get(context).lastScreenIndex);
                    }
                  : onLeadPress,
            )
          : null,
      title: titleWidget,
      actions: [
        actionWidget != null ? actionWidget : Container(),
      ],
      iconTheme:
          IconThemeData(color: isSearch ? Colors.white : Colors.black, size: 3),
      centerTitle: true,
    );
