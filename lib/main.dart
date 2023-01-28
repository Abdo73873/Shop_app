// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/shop_states.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boring_scrern.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

void main() async {
  //بيتاكد ان كل حاجه هنا في المبثود خلصت بعدين بيرن الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(
    key: 'onBoarding',
  );
  token = CacheHelper.getData(
    key: 'token',
  );

  String? lang=CacheHelper.getData(key: 'language');
  lang!=null? language=lang:language='en';
  Widget startWidget;

  if (onBoarding != null) {
    if (token != null) {
      startWidget = ShopHomeLayout();
    } else {
      startWidget = ShopLoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget));
}


class MyApp extends StatelessWidget {
  Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesModel()
        ..getFavoritesModel()
        ..getUser()
        ..getCart(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: startWidget,

          );
        },
      ),
    );
  }
}
