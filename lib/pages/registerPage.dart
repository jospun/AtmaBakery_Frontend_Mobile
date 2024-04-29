import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:p3l_atmabakery/pages/privacyPolicyPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String selectedDate = '';
  bool isPasswordVisible = false;
  bool isPasswordVisible2 = false;
  bool checkedValue = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerNoTelp = TextEditingController();
  TextEditingController contollerDate = TextEditingController();

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

  void submission() async {
    DateFormat originalFormat = DateFormat("EEEE, dd MMMM yyyy", "en_US");
    DateTime parsedDate = originalFormat.parse(selectedDate);

    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    String formattedDate = newFormat.format(parsedDate);

    print(formattedDate);

    User input = User(
      email: controllerEmail.text,
      nama: controllerNama.text,
      password: controllerPassword.text,
      password_confirmation: controllerConfirmPassword.text,
      no_telp: controllerNoTelp.text,
      tanggal_lahir: formattedDate,
    );
    try {
      await userClient.create(input);
      showSnackbar(context, "Berhasil Register", Colors.green);
    } catch (e) {
      print(e.toString());
      showSnackbar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
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
                        Center(
                            child: TextFormField(
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintStyle: TextStyle(height: 0.13.h)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silahkan Masukkan Email Anda!';
                            } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                                .hasMatch(value)) {
                              return 'Email tidak valid';
                            }
                            return null;
                          },
                        )),
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
                        Center(
                            child: TextFormField(
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintStyle: TextStyle(height: 0.13.h)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silahkan masukkan nama';
                            }
                            return null;
                          },
                        )),
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
                        Center(
                            child: TextFormField(
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintStyle: TextStyle(height: 0.13.h)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silahkan masukkan Nomor Telepon';
                            } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Nomor Telepon Tidak Valid!';
                            }
                            return null;
                          },
                        )),
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
                        TextFormField(
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
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
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
                              return 'Silahkan Masukkan Tanggal Lahir';
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
                        Center(
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
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  !isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: !isPasswordVisible
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                              ),
                            ),
                            obscureText: !isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Tidak Boleh Kosong';
                              } else if (value.length < 8) {
                                return 'Password Minimal 8 karakter';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 2.h),
                        const SizedBox(
                          child: Text(
                            "Konfirmasi Password",
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
                            controller: controllerConfirmPassword,
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
                              hintText: 'Konfirmasi Password Anda',
                              hintStyle: TextStyle(height: 0.13.h),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible2 = !isPasswordVisible2;
                                  });
                                },
                                icon: Icon(
                                  !isPasswordVisible2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: !isPasswordVisible2
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                              ),
                            ),
                            obscureText: !isPasswordVisible2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Tidak Boleh Kosong';
                              } else if (value.length < 8) {
                                return 'Password Minimal 8 karakter';
                              } else if (value != controllerPassword.text) {
                                return 'Konfirmasi password berbeda dengan password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 0.08.h),
                        Center(
                          child: CheckboxListTile(
                            title: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                  const TextSpan(
                                    text:
                                        "Dengan mencentang checkbox ini, anda telah setuju dengan ",
                                  ),
                                  TextSpan(
                                    text: "Term of Service ",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const PrivacyPolicyPage())),
                                  ),
                                  const TextSpan(
                                    text: "dan ",
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.of(context)
                                          .push(MaterialPageRoute(
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
                                onPressed: () => {
                                      if (_formKey.currentState!.validate() &&
                                          checkedValue != false)
                                        {submission()}
                                    },
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
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
