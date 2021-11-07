import 'package:flutter/material.dart';

class AddCartButton extends StatelessWidget {
  var onPress;
  Color color;
  Color iconColor;
  IconData icon;
  double iconSize;
  AddCartButton({
    required this.onPress,
    this.iconColor = Colors.white,
    this.color = Colors.blue,
    this.icon = Icons.add,
    this.iconSize = 20,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      child: MaterialButton(
        padding: EdgeInsetsDirectional.only(end: 2),
        onPressed: onPress,
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
