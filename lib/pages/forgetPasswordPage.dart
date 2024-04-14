import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  TextEditingController controllerEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool emailSent = false;

  @override
  Widget build(BuildContext context) {
    void sendEmailForResetPassword() async {
      try {
        await userClient.sendEmailForResetPassword(controllerEmail.text);
        showSnackbar(context,
            "Email berhasil dikirim ke ${controllerEmail.text}", Colors.green);
        setState(() {
          emailSent = true;
        });
      } catch (e) {
        showSnackbar(context, e.toString(), Colors.red);
      }
    }

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
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        child: Text(
                          "Lupa Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        child: Text(
                          "Mohon masukkan alamat email yang terhubung dengan akun Anda. Kami akan mengirimkan instruksi reset password ke email tersebut.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 3.5.h),
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
                      Center(
                          child: TextFormField(
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            hintStyle: TextStyle(height: 0.13.h)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                      )),
                      SizedBox(height: 5.h),
                      Center(
                        child: SizedBox(
                          width: 55.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: emailSent
                                    ? Colors.grey
                                    : const Color.fromRGBO(255, 68, 76, 1),
                              ),
                              onPressed: emailSent
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        sendEmailForResetPassword();
                                      }
                                    },
                              child: const Text(
                                'Kirim Email',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "Masuk dengan password yang baru",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: " Masuk Sekarang",
                                style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15,
                                    color: Color.fromRGBO(90, 175, 220, 1)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage())),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSnackbar(BuildContext context, String msg, Color bg) {
  final Scaffold = ScaffoldMessenger.of(context);
  Scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
    action: SnackBarAction(
      label: 'hide',
      onPressed: Scaffold.hideCurrentSnackBar,
    ),
  ));
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
