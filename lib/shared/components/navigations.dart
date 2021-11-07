import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:flutter/material.dart';

void navigateTo({
  required context,
  required nextScreen,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );

void navigateAndFinish({
  required context,
  required nextScreen,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false,
    );

void navigateAndBackHome({
  required context,
  required nextScreen,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => true,
    );
