import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/client/firebase_api.dart';
import 'package:p3l_atmabakery/pages/forgetPasswordPage.dart';
import 'package:p3l_atmabakery/pages/homeNavbar.dart';
import 'package:p3l_atmabakery/pages/customer/homePage.dart';
import 'package:p3l_atmabakery/pages/registerPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<String?> login() async {
      try {
        await Firebase.initializeApp();
        await FirebaseApi().initNotifications();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? fcmToken = prefs.getString('fcm-token');
        print(fcmToken);
        String loggedIn = await userClient.Login(
            controllerEmail.text, controllerPassword.text, fcmToken);
        showSnackbar(context, "Berhasil Login", Colors.green);
        return loggedIn;
      } catch (e) {
        showSnackbar(context, e.toString(), Colors.red);
        return null;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [
                      Color.fromRGBO(244, 142, 40, 1),
                      Color.fromRGBO(237, 202, 180, 1),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0, left: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Selamat Datang Kembali!',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Masuk dan pesan segera kue yang memiliki\ncita rasa tinggi yang diproses sepenuh hati.",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.22,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.2),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: controllerEmail,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 142, 40, 1)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(210, 145, 79, 1),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 179, 179)),
                              ),
                              hintText: 'Masukkan email Anda',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintStyle: TextStyle(height: 0.13.h),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Tidak Boleh Kosong!';
                              } else if (!value.contains('@')) {
                                return 'Email tidak valid';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Kata Sandi",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: controllerPassword,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(244, 142, 40, 1)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(210, 145, 79, 1),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 181, 179, 179)),
                              ),
                              hintText: 'Masukkan Kata Sandi Anda',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintStyle: TextStyle(height: 0.13.h),
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
                                return 'Kata Sandi Tidak Boleh Kosong!';
                              } else if (value.length < 8) {
                                return 'Kata Sandi Minimal 8 Karakte!r';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Lupa Kata Sandi?',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(90, 175, 220, 1)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: 80.w,
                              height: 5.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(244, 142, 40, 1)),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    String? loggedIn = await login();
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('token', loggedIn!);
                                    print(prefs.getString('token')!);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const HomeNavbar(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 35),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(90, 175, 220, 1)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage())),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
