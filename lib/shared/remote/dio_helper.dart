import 'package:dio/dio.dart';
import 'package:e_commerce_app/shared/constrains.dart';
import 'package:e_commerce_app/shared/end_points.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
      ),
    );
  }

// post
  static Future<Response> postData(
      {required endPoint, Map<String, dynamic>? data, language = 'en'}) {
    String? userToken = CacheHelper.getData(key: 'userToken').toString();
    String? lang = CacheHelper.getData(key: 'lang').toString();
    return dio.post(
      endPoint,
      data: data,
      options: Options(headers: {
        'lang': language,
        'Content_Type': 'application/json',
        'Authorization': userToken != null ? userToken : '',
      }),
    );
  }

// put
  static Future<Response> putData(
      {required endPoint, Map<String, dynamic>? data, language = 'en'}) {
    String? userToken = CacheHelper.getData(key: 'userToken').toString();
    return dio.put(
      endPoint,
      data: data,
      options: Options(headers: {
        'lang': language,
        'Content_Type': 'application/json',
        'Authorization': userToken != null ? userToken : '',
      }),
    );
  }

  // delete
  static Future<Response> deleteData(
      {required endPoint, Map<String, dynamic>? data, language = 'en'}) {
    String? userToken = CacheHelper.getData(key: 'userToken').toString();
    return dio.delete(
      endPoint,
      data: data,
      options: Options(headers: {
        'lang': language,
        'Content_Type': 'application/json',
        'Authorization': userToken != null ? userToken : '',
      }),
    );
  }

// get
  static Future<Response> getData({required endPoint, language = 'en'}) {
    String? userToken = CacheHelper.getData(key: 'userToken').toString();
    return dio.get(
      endPoint,
      options: Options(headers: {
        'lang': language,
        'Content_Type': 'application/json',
        'Authorization': userToken != null ? userToken : '',
      }),
    );
  }
}
