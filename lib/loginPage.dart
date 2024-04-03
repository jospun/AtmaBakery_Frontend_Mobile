import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/forgetPasswordPage.dart';
import 'package:p3l_atmabakery/registerPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool isPasswordVisible = false;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  CustomPaint(
                    painter: ShapesPainter(),
                    child: Container(height: 110),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logoKecil.png',
                      width: 47.5.w,
                      height: 16.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      child: Text(
                        "Masuk ke akun anda",
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      child: Text(
                        "Masuk dan pesan segera kue yang memiliki cita rasa tinggi",
                        style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    const SizedBox(
                      child: Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: 0.8.h),
                    SizedBox(
                      height: 5.h,
                      child: Center(
                          child: TextField(
                        controller: controllerEmail,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(234, 234, 234, 1),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Email Anda',
                            hintStyle: TextStyle(height: 0.13.h)),
                      )),
                    ),
                    SizedBox(height: 2.h),
                    const SizedBox(
                      child: Text(
                        "Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: 0.8.h),
                    SizedBox(
                      height: 5.h,
                      child: Center(
                        child: TextFormField(
                          controller: controllerPassword,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(234, 234, 234, 1),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Password Anda',
                            hintStyle: TextStyle(height: 0.13.h),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: isPasswordVisible
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                            ),
                          ),
                          obscureText: isPasswordVisible,
                        ),
                      ),
                    ),
                    SizedBox(height: 0.3.h),
                    SizedBox(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordPage(),
                                ));
                          },
                          child: const Text('Lupa Password?',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(90, 175, 220, 1)))),
                    ),
                    SizedBox(height: 0.3.h),
                    Center(
                      child: SizedBox(
                        width: 55.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor:
                                  const Color.fromRGBO(255, 68, 76, 1),
                            ),
                            onPressed: () => {},
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(height: 27.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Belum Punya Akun?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: " Daftar Sekarang",
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15,
                                    color: Color.fromRGBO(90, 175, 220, 1)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const double _kCurveHeight = 35;

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(
        size.width / 2, 2.3 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..color = const Color.fromRGBO(255, 68, 76, 1));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
