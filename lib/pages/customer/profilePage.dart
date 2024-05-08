import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/customer/historiPemesananPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/pages/customer/profilSayaPage.dart';
import 'package:p3l_atmabakery/pages/customer/historiPemesananPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  User? currentUser;
  bool _isLoading = true;
  String? nama, pfp;
  String? email, id_role;

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    id_role = prefs.getString('id_role');
    email = prefs.getString('email');
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    _isLoading = true;
    print(email);
    try {
      currentUser = await userClient.showSelf();
      setState(() {
        nama = currentUser!.nama;
      });
      _isLoading = false;
    } catch (e) {
      print("Error fetching SharedPreferences: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    if (currentUser == null) {
      setState(() {
        nama = "Guest";
        email = "Please log In";
      });
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    main();
    return Scaffold(
      body: !_isLoading
          ? Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 25.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://res.cloudinary.com/daorbrq8v/image/upload/f_auto,q_auto/v1/atma-bakery/p27iua0trapjq3hb6vxz"), // Ganti dengan path gambar Anda
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: currentUser?.foto_profil !=
                                          null
                                      ? NetworkImage(currentUser!.foto_profil!)
                                          as ImageProvider<Object>
                                      : const NetworkImage(
                                              "https://res.cloudinary.com/daorbrq8v/image/upload/f_auto,q_auto/v1/atma-bakery/r1xujbu1yfoenzked4rc")
                                          as ImageProvider<Object>,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Hi, $nama",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                Text(
                                  "$email",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Saldo Saya',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.attach_money, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Poin Saya',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.monetization_on,
                                      color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(244, 142, 40, 1),
                            Colors.white,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 110,
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(height: 2.h),
                          buildRow(Icons.account_circle, 'Profil Saya', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilSayaPage(),
                              ),
                            );
                          }),
                          buildRow(Icons.info, 'Tentang Kami', () {}),
                          buildRow(Icons.attach_money, 'Histori Pemesanan', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoriPemesananPage(),
                              ),
                            );
                          }),
                          buildRow(Icons.library_books, 'Ketentuan', () {}),
                          buildRow(Icons.security, 'Privacy Policy', () {}),
                          buildRow(Icons.logout, 'Logout', () {}),
                        ],
                      ),
                    ),
                    (currentUser != null)
                        ? ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              FocusManager.instance.primaryFocus!.unfocus();
                              String token =
                                  prefs.getString('token').toString();
                              await userClient.Logout(token);
                              prefs.remove('token');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                              );
                            },
                            child: Text("Logout"))
                        : Center(
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
                )),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

Widget buildRow(IconData icon, String title, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    ),
  );
}
