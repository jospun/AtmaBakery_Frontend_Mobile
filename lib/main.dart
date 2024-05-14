import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/splashScreen.dart';
//import 'package:p3l_atmabakery/pages/homeNavbar.dart';
//import 'package:p3l_atmabakery/pages/loginPage.dart';
//import 'package:p3l_atmabakery/pages/welcomePage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:p3l_atmabakery/data/client/firebase_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token') ?? '';

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        Device.orientation == Orientation.portrait
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5,
              );
        Device.screenType == ScreenType.tablet
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5.h,
              );
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
