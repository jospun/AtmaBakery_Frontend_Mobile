import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/homeNavbar.dart';
import 'package:p3l_atmabakery/pages/welcomePage.dart';

class SplashScreen extends StatefulWidget {
  final String token;
  const SplashScreen({this.token = "", Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _countdown = 3;
  String token = "";
  @override
  void initState() {
    super.initState();
    token = widget.token;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    token.isEmpty ? WelcomePage() : HomeNavbar(),
              ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF48E28),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/iconBakery.png',
                  width: 500,
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
