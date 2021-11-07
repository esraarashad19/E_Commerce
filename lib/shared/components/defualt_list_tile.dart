import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';

import '../../app_localization.dart';

class DefualtListTile extends StatelessWidget {
  var onPress;
  String title;
  IconData? leadIcon;
  IconData? trailIcon;
  String? subTitle;
  bool isTrailing;
  bool isSelected;
  DefualtListTile({
    required this.title,
    required this.onPress,
    this.leadIcon,
    this.subTitle,
    this.isTrailing = true,
    this.isSelected = false,
    this.trailIcon = Icons.arrow_forward_ios_outlined,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPress,
          leading: leadIcon != null
              ? Icon(
                  leadIcon,
                  color: appNormalColor,
                  size: 20,
                )
              : null,
          title: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.translate(title)!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              if (subTitle != null)
                Text(
                  subTitle!,
                  style: normalTextStyle,
                ),
            ],
          ),
          trailing: isTrailing
              ? Icon(
                  trailIcon,
                  size: isSelected ? 25 : 15,
                  color: isSelected ? Colors.blue : appNormalColor,
                )
              : null,
          minVerticalPadding: 20,
          selected: isSelected,
        ),
        Container(
          height: 1,
          color: Colors.blueGrey[100],
        )
      ],
    );
  }
}
