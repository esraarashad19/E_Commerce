import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/screens/user_signing/cubit/states.dart';
import 'package:e_commerce_app/shared/end_points.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:e_commerce_app/shared/remote/dio_helper.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(InitialUserState());
  static UserCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  bool isTextVisible = false;
// hide or visible password text
  void changeTextVisibility(bool value) {
    isTextVisible = value;
    emit(ChangePasswordVisibilityState());
  }

// user register
  void userRegister({
    required email,
    required password,
    required name,
    required phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      endPoint: REGISTER,
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      userModel = UserModel.fromMap(value.data);
      if (userModel!.status) {
        emit(RegisterSuccessState());
        CacheHelper.saveData(key: 'userEmail', value: userModel!.data!.email);
        CacheHelper.saveData(key: 'userImage', value: userModel!.data!.image);
        CacheHelper.saveData(key: 'userName', value: userModel!.data!.name);
        CacheHelper.saveData(key: 'userToken', value: userModel!.data!.token);
        print(userModel!.status);
        print(userModel!.message);
        print(userModel!.data!.name);
        print(userModel!.data!.email);
        print(userModel!.data!.phone);
        print(userModel!.data!.token);
      } else {
        print('___________else error bloc__________');
        print(userModel!.status);
        print(userModel!.message);
        emit(RegisterErrorState(userModel!.message));
      }
    }).catchError((error) {
      print('_____________catch error bloc__________');
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  // user login
  void userLogin({
    required email,
    required password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      endPoint: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      userModel = UserModel.fromMap(value.data);
      if (userModel!.status) {
        emit(LoginSuccessState());
        CacheHelper.saveData(key: 'userEmail', value: userModel!.data!.email);
        CacheHelper.saveData(key: 'userImage', value: userModel!.data!.image);
        CacheHelper.saveData(key: 'userName', value: userModel!.data!.name);
        CacheHelper.saveData(key: 'userToken', value: userModel!.data!.token);
        print(userModel!.status);
        print(userModel!.message);
        print(userModel!.data!.name);
        print(userModel!.data!.email);
        print(userModel!.data!.phone);
        print(userModel!.data!.token);
      } else {
        print(userModel!.status);
        print(userModel!.message);
        emit(LoginErrorState(userModel!.message));
      }
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
