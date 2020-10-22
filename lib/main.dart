import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaon/const/app_color.dart';
import 'package:gaon/locator.dart';
import 'package:gaon/screen/profile/box_history_screen.dart';
import 'package:gaon/screen/profile/profile_screen.dart';
import 'package:gaon/screen/login_screen.dart';
import 'package:gaon/screen/start/init_screen.dart';
import 'package:gaon/screen/register/register_screen.dart';
import 'package:gaon/screen/start/start_screen1.dart';

import 'network/cached_shared_preference.dart';
import 'screen/home/about_box_screen.dart';
import 'screen/intro_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(
    () async {
      setupServiceLocator();
      await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      await locator.allReady();

      runApp(MyApp());
    },
    onError: (Object error, StackTrace stackTrace) {
      // print('clear');
      // locator<CachedSharedPreference>().clearAll();
      debugPrint(error.toString());
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/init': (context) => InitScreen(),
        '/login': (context) => LoginScreen(),
        '/start': (context) => IntroScreen(),
        '/register': (context) => RegisterScreen(),
        '/intro': (context) => StartScreen(),
        '/about_box_screen': (context) => AboutBoxScreen(),
        '/profile': (context) => ProfileScreen(),
        '/box_history': (context) => BoxHistoryScreen(),
      },
      theme: ThemeData(
        fontFamily: 'lotte_happy_light',
        canvasColor: Colors.white,
        accentColor: AppColor.mainRedColor,
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: locator<CachedSharedPreference>().haveUser() ? InitScreen() : LoginScreen(),
    );
  }
}
