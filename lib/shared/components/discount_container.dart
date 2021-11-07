import 'package:flutter/material.dart';

class DiscountContainer extends StatelessWidget {
  String text;
  DiscountContainer({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$text%',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
