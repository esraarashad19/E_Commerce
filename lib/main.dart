import 'package:e_commerce_app/app_localization.dart';
import 'package:e_commerce_app/layout/cubit/states.dart';
import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:e_commerce_app/screens/orders/cubit/cubit.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';
import 'package:e_commerce_app/screens/user_signing/cubit/cubit.dart';
import 'package:e_commerce_app/shared/local/cache_helper.dart';
import 'package:e_commerce_app/shared/my_bloc_observer.dart';
import 'package:e_commerce_app/shared/remote/dio_helper.dart';
import 'package:e_commerce_app/layout/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  String? token = CacheHelper.getData(key: 'userToken').toString();

  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  String? userToken;
  MyApp(this.userToken);
  @override
  Widget build(BuildContext context) {
    if (CacheHelper.getData(key: 'lang') == null)
      CacheHelper.saveData(key: 'lang', value: 'en');
    print('userToken = $userToken');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getProducts()
            ..getFavoritesProducts()
            ..getCarts()
            ..getHomeProducts()
            ..getCategories(),
        ),
        BlocProvider(create: (context) => OrdersCubit()..getOrders()),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              ShopCubit.get(context).localization,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'EG'),
            ],

            locale: CacheHelper.getData(key: 'lang').toString() == 'en'
                ? Locale('en', 'US')
                : Locale('ar', 'EG'),

            debugShowCheckedModeBanner: false,
            // home: LoginScreen(),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
