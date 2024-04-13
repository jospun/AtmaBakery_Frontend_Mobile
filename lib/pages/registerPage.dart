import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:p3l_atmabakery/pages/privacyPolicyPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String selectedDate = '';
  bool isPasswordVisible = false;
  bool checkedValue = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerNoTelp = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('EEEE, dd MMMM yyyy').format(picked);
      });
    }
  }

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
              SizedBox(height: 1.h),
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
                          "Daftarkan diri anda",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        child: Text(
                          "Daftar segera dan akses segala fitur dari Atma Bakery yang telah menanti anda",
                          style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(height: 2.h),
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
                              fillColor: Color.fromRGBO(234, 234, 234, 1),
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
                          "Nama",
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
                          controller: controllerNama,
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
                              hintText: 'Nama Anda',
                              hintStyle: TextStyle(height: 0.13.h)),
                        )),
                      ),
                      SizedBox(height: 2.h),
                      const SizedBox(
                        child: Text(
                          "Nomor Telepon",
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
                          controller: controllerNoTelp,
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
                              hintText: 'Nomor Telepon Anda',
                              hintStyle: TextStyle(height: 0.13.h)),
                        )),
                      ),
                      SizedBox(height: 2.h),
                      const SizedBox(
                        child: Text(
                          "Tanggal Lahir",
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
                        child: TextFormField(
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
                            hintText: 'Tanggal Lahir Anda',
                            hintStyle: TextStyle(height: 0.13.h),
                            prefixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: const Icon(Icons.calendar_today),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                          validator: (value) {
                            if (selectedDate.isEmpty) {
                              return 'Tanggal Lahir Anda';
                            }
                            return null;
                          },
                          controller: TextEditingController(
                            text: selectedDate.isEmpty ? null : selectedDate,
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
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
                      SizedBox(height: 0.08.h),
                      SizedBox(
                        height: 4.h,
                        width: 100.w,
                        child: CheckboxListTile(
                          title: RichText(
                              text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: <TextSpan>[
                                const TextSpan(
                                  text:
                                      "Dengan mencentang checkbox ini, anda telah setuju dengan ",
                                ),
                                TextSpan(
                                  text: "Term of Service ",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PrivacyPolicyPage())),
                                ),
                                const TextSpan(
                                  text: "dan ",
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PrivacyPolicyPage())),
                                ),
                              ])),
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = !checkedValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      SizedBox(height: 0.08.h),
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
                                'Daftar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
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
                                text: "Sudah Punya Akun?",
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
