import 'package:e_commerce_app/screens/user_signing/cubit/cubit.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/material.dart';

import '../../app_localization.dart';

class DefaultTextField extends StatelessWidget {
  TextInputType keyType;
  TextEditingController myController;
  String lablText;
  String validatText;
  bool isPassword;
  DefaultTextField({
    required this.myController,
    required this.keyType,
    required this.lablText,
    required this.validatText,
    this.isPassword = false,
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
        //primaryColor: Colors.grey[200],
        primaryColorDark: Colors.grey[100],
      ),
      child: TextFormField(
        keyboardType: keyType,
        controller: myController,
        obscureText:
            isPassword && !UserCubit.get(context).isTextVisible ? true : false,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
          labelText: AppLocalizations.of(context)!.translate(lablText)!,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    UserCubit.get(context).changeTextVisibility(
                        !UserCubit.get(context).isTextVisible);
                  },
                  icon: isPassword && !UserCubit.get(context).isTextVisible
                      ? Icon(
                          Icons.remove_red_eye_outlined,
                        )
                      : Icon(
                          Icons.visibility_off_outlined,
                        ),
                )
              : null,
        ),
        validator: (value) {
          if (value!.isEmpty)
            return AppLocalizations.of(context)!.translate(validatText)!;
          return null;
        },
      ),
    );
  }
}
