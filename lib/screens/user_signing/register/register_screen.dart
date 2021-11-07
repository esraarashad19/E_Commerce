import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:e_commerce_app/screens/user_signing/cubit/cubit.dart';
import 'package:e_commerce_app/screens/user_signing/cubit/states.dart';
import 'package:e_commerce_app/shared/components/default_auth_circular_button.dart';
import 'package:e_commerce_app/shared/components/default_text_field.dart';
import 'package:e_commerce_app/shared/components/defualt_rectangle_button.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:e_commerce_app/shared/components/show_message.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app_localization.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  // var firstnameController = TextEditingController();
  // var lastnameController = TextEditingController();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState)
          navigateAndFinish(
            context: context,
            nextScreen: MainLayout(),
          );
        if (state is RegisterErrorState) {
          showMessageBox(
            message: state.message!,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              AppLocalizations.of(context)!.translate('Register')!,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('Register')!,
                          style: mainTitleTextStyle,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            //isRepeatingAnimation: true,
                            stopPauseOnTap: true,
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText(
                                'Email',
                              ),
                              RotateAnimatedText(
                                'Facebook',
                              ),
                              RotateAnimatedText(
                                'Google',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .translate('Create account to continue')!,
                    style: normalTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      DefualtAuthCircularButton(
                        fillColor: Colors.blue[900]!,
                        icon: FontAwesomeIcons.facebookF,
                        onpress: () {},
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DefualtAuthCircularButton(
                        fillColor: Color(0xFFE44133),
                        icon: FontAwesomeIcons.googlePlusG,
                        onpress: () {},
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      DefualtAuthCircularButton(
                        fillColor: Colors.blue,
                        icon: FontAwesomeIcons.phone,
                        messageAuth: true,
                        onpress: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //first name text field
                        // DefaultTextField(
                        //   keyType: TextInputType.text,
                        //   myController: cubit.firstnameController,
                        //   lablText: 'First Name*',
                        //   validatText: 'First Name is required',
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // // last name text field
                        // DefaultTextField(
                        //   keyType: TextInputType.text,
                        //   myController: cubit.lastnameController,
                        //   lablText: 'Last Name*',
                        //   validatText: 'Last Name is required',
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        //  username text field
                        DefaultTextField(
                          keyType: TextInputType.text,
                          myController: usernameController,
                          lablText: 'User Name*',
                          validatText: 'User Name is required',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        //  phone number text field
                        DefaultTextField(
                          keyType: TextInputType.number,
                          myController: phoneController,
                          lablText: 'Phone*',
                          validatText: 'Phone is required',
                        ),
                        SizedBox(
                          height: 16,
                        ),

                        //   email text field
                        DefaultTextField(
                          keyType: TextInputType.emailAddress,
                          myController: emailController,
                          lablText: 'Email*',
                          validatText: 'Email is required',
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        // password text field
                        DefaultTextField(
                          keyType: TextInputType.visiblePassword,
                          isPassword: true,
                          myController: passwordController,
                          lablText: 'Password',
                          validatText: 'Password is required',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .translate('Accept the Terms and Conditions')!,
                    style: normalTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is! RegisterLoadingState)
                    DefualtRectangleButton(
                      title: 'Sign up',
                      onpress: () {
                        if (formKey.currentState!.validate()) {
                          UserCubit.get(context).userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            name: usernameController.text,
                            phone: passwordController.text,
                          );
                        }
                      },
                    ),
                  if (state is RegisterLoadingState)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate('Already have account?')!,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
