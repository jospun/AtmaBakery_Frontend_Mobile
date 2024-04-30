import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/homeNavbar.dart';
import 'package:p3l_atmabakery/pages/customer/homePage.dart';
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return WideLayout();
              } else {
                return NarrowLayout();
              }
            },
          ),
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
              'assets/images/cakes.png',
            ),
            SizedBox(height: 2.h),
            Text(
              'Raih Kelezatan Bersama Kami',
               textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Kue-kue ini dibuat sepenuh hati dengan ketelitian dan menggunakan bahan-bahan berkualitas pilihan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Montserrat',
                color: Color.fromARGB(255, 53, 52, 52),
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 85.w,
              height: 6.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(244, 142, 40, 1),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_box_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 7), 
                    Text(
                      'Masuk ke Akun',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 85.w,
                height: 6.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color.fromRGBO(244, 142, 40, 1)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 53, 52, 52),
                      ),
                      SizedBox(width: 7), 
                      Text(
                        'Daftar Akun',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color.fromARGB(255, 53, 52, 52),
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 85.w,
                height: 6.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color.fromRGBO(244, 142, 40, 1)),
                  ),
                  onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeNavbar(),
                            ),
                          )
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_sharp,
                        color: Color.fromARGB(255, 53, 52, 52),
                      ),
                      SizedBox(width: 7), 
                      Text(
                        'Sebagai Tamu',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color.fromARGB(255, 53, 52, 52),
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
              'assets/images/cakes.png',
              width: 50.w,
              height: 50.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                  width: 40.w,
                  height: 6.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(244, 142, 40, 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_box_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(width: 7), 
                        Text(
                          'Masuk ke Akun',
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                  SizedBox(
                    width: 40.w,
                    height: 6.h,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: const Color.fromRGBO(244, 142, 40, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 53, 52, 52),
                          ),
                          SizedBox(width: 7), 
                          Text(
                            'Daftar Akun',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 53, 52, 52),
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 40.w,
                height: 6.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color.fromRGBO(244, 142, 40, 1)),
                  ),
                  onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeNavbar(),
                            ),
                          )
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_sharp,
                        color: Color.fromARGB(255, 53, 52, 52),
                      ),
                      SizedBox(width: 7), 
                      Text(
                        'Sebagai Tamu',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color.fromARGB(255, 53, 52, 52),
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ],
            ),
          ]),
    );
  }
}
