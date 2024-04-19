import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/homeNavbar.dart';
import 'package:p3l_atmabakery/pages/homePage.dart';
import 'package:p3l_atmabakery/pages/registerPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return WideLayout();
            } else {
              return NarrowLayout();
            }
          },
        ),
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logoAtma.png',
              width: 50.w,
              height: 20.h,
            ),
            SizedBox(height: 7.h),
            SizedBox(
              width: 80.w,
              height: 4.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 68, 76, 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 80.w,
              height: 4.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 68, 76, 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ));
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 80.w,
              height: 4.h,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 68, 76, 1),
                  ),
                  onPressed: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeNavbar(),
                          ),
                        )
                      },
                  child: const Text(
                    'Continue with Guest',
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ]),
    );
  }
}

class WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logoAtma.png',
              width: 50.w,
              height: 20.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40.w,
                  height: 8.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 68, 76, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 40.w,
                  height: 8.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 68, 76, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 40.w,
                  height: 8.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 68, 76, 1),
                      ),
                      onPressed: () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeNavbar(),
                              ),
                            )
                          },
                      child: const Text(
                        'Continue with Guest',
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ]),
    );
  }
}
