import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
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
                        'Lupa Kata Sandi!',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Mohon masukkan alamat email yang terhubung dengan akun Anda. Kami akan mengirimkan instruksi reset password ke email tersebut.",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
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
                    padding: const EdgeInsets.all(25.0),
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
                              hintText: 'Email Anda',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              hintStyle: TextStyle(height: 0.13.h),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@')) {
                                return 'Email tidak valid';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: SizedBox(
                              width: 80.w,
                              height: 5.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(244, 142, 40, 1)),
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
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                    text: "Masuk dengan password yang baru",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Masuk Sekarang",
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(90, 175, 220, 1),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.of(context)
                                          .push(MaterialPageRoute(
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
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: bg,
    action: SnackBarAction(
      label: 'x',
      onPressed: scaffold.hideCurrentSnackBar,
    ),
  ));
}
