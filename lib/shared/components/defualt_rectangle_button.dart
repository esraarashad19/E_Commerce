import 'package:flutter/material.dart';

import '../../app_localization.dart';

class DefualtRectangleButton extends StatelessWidget {
  var onpress;
  String title;
  double width;
  DefualtRectangleButton({
    required this.onpress,
    required this.title,
    this.width = double.infinity,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      child: MaterialButton(
        color: Colors.blue,
        child: Text(
          AppLocalizations.of(context)!.translate(title)!,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onpress,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(12.0),
      ),
    );
  }
}
