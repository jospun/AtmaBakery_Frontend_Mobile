import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/welcomePage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          home: const WelcomePage(),
        );
      },
    );
  }
}
