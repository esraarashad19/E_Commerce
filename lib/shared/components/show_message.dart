import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessageBox({
  required String message,
  required BuildContext context,
  String title = 'error',
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

showToast({
  required String msg,
  required Color backColor,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
      textColor: Colors.white,
      backgroundColor: backColor,
      timeInSecForIosWeb: 5,
      toastLength: Toast.LENGTH_LONG,
    );
