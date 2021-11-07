import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DefualtAuthCircularButton extends StatelessWidget {
  Color fillColor;
  IconData icon;
  bool messageAuth;
  var onpress;
  DefualtAuthCircularButton({
    required this.fillColor,
    required this.icon,
    required this.onpress,
    this.messageAuth = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: RawMaterialButton(
        fillColor: fillColor,
        onPressed: onpress,
        child: messageAuth
            ? Icon(
                icon,
                size: 20,
                color: Colors.white,
              )
            : CircleAvatar(
                backgroundColor: Colors.white,
                radius: 10,
                child: Icon(
                  icon,
                  size: 15,
                  color: fillColor,
                ),
              ),
        shape: CircleBorder(),
        padding: EdgeInsets.all(15.0),
        elevation: 2,
      ),
    );
  }
}
