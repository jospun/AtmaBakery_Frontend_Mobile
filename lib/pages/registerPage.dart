import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:p3l_atmabakery/pages/privacyPolicyPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                        'Selamat Datang!',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Daftar segera dan akses segala\nfitur dari Atma Bakery!",
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Center(
                            child: TextFormField(
                              controller: controllerEmail,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(210, 145, 79, 1),), 
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 181, 179, 179)), 
                                  ),
                                hintText: 'Email Anda',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintStyle: TextStyle(height: 0.13.h),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silahkan Masukkan Email Anda!';
                                } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                                    .hasMatch(value)) {
                                  return 'Email tidak valid';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Center(
                            child: TextFormField(
                              controller: controllerNama,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(210, 145, 79, 1),), 
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 181, 179, 179)), 
                                  ),
                                hintText: 'Nama Anda',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintStyle: TextStyle(height: 0.13.h),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silahkan masukkan nama';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 8),
                          Center(
                            child: TextFormField(
                              controller: controllerNoTelp,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(210, 145, 79, 1),), 
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 181, 179, 179)), 
                                  ),
                                hintText: 'Nomor Telepon Anda',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintStyle: TextStyle(height: 0.13.h),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Silahkan masukkan Nomor Telepon';
                                } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Nomor Telepon Tidak Valid!';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(210, 145, 79, 1),), 
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 181, 179, 179)), 
                              ),
                              hintText: 'Tanggal Lahir Anda',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, 
                                horizontal: 10.0,
                              ),
                              hintStyle: TextStyle(height: 0.13.h),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: const Icon(Icons.calendar_today),
                                ),
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

                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Center(
                            child: TextFormField(
                              controller: controllerPassword,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(210, 145, 79, 1),), 
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 181, 179, 179)), 
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
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Center(
                            child: TextFormField(
                              controller: controllerConfirmPassword,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                                              filled: false,
                              fillColor: const Color.fromRGBO(234, 234, 234, 1),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(210, 145, 79, 1),), 
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 181, 179, 179)), 
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
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: 80.w,
                              height: 5.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                backgroundColor:const Color.fromRGBO(244, 142, 40, 1)
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
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
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

void showSnackbar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
    ),
  );
}
