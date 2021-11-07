import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:e_commerce_app/screens/user_signing/cubit/cubit.dart';
import 'package:e_commerce_app/screens/user_signing/cubit/states.dart';
import 'package:e_commerce_app/screens/user_signing/register/register_screen.dart';
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

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          navigateAndFinish(
            context: context,
            nextScreen: MainLayout(),
          );
          ShopCubit.get(context).getProducts();
          ShopCubit.get(context).getHomeProducts();
          ShopCubit.get(context).getFavoritesProducts();
          ShopCubit.get(context).getCarts();
        }
        if (state is LoginErrorState) {
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
              AppLocalizations.of(context)!.translate('Login')!,
              style: titleTextStyle,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black, size: 3),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // SizedBox(height: 40.0),
                        Text(
                          AppLocalizations.of(context)!.translate('Login')!,
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
                            stopPauseOnTap: true,
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText('Email'),
                              RotateAnimatedText('Facebook'),
                              RotateAnimatedText('Google'),
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
                    height: 25,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .translate('Accept the Terms and Conditions')!,
                    style: normalTextStyle,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultTextField(
                          keyType: TextInputType.text,
                          myController: emailController,
                          lablText: 'Username or email address',
                          validatText: 'Username is required',
                        ),
                        SizedBox(
                          height: 16,
                        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(AppLocalizations.of(context)!
                            .translate('Forgot Password')!),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is! LoginLoadingState)
                    DefualtRectangleButton(
                      title: 'Sign in',
                      onpress: () {
                        if (formKey.currentState!.validate()) {
                          UserCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                    ),
                  if (state is LoginLoadingState)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .translate('Don\'t have account?')!,
                      ),
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.translate('Register')!,
                        ),
                        onPressed: () {
                          navigateTo(
                            context: context,
                            nextScreen: RegisterScreen(),
                          );
                        },
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
