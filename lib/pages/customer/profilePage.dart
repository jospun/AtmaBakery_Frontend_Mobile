import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/formatter.dart';
import 'package:p3l_atmabakery/pages/customer/historiPemesananPage.dart';
import 'package:p3l_atmabakery/pages/customer/ketentuanPage.dart';
import 'package:p3l_atmabakery/pages/customer/privacyPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/pages/customer/profilSayaPage.dart';
import 'package:p3l_atmabakery/pages/customer/tentangKamiPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  bool _isLoading = false;
  String? nama, pfp;
  String? email, id_role;
  double saldo = 0.0;
  int poin = 0;

  Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    try {
      User data = User(
          email: prefs.getString('email'),
          nama: prefs.getString('nama'),
          foto_profil: prefs.getString('foto_profil') == ""
              ? null
              : prefs.getString('foto_profil'),
          id_role: prefs.getString('id_role'));
      saldo = prefs.getDouble('saldo') ?? 0.0;
      poin = prefs.getInt('poin') ?? 0;
      _isLoading = false;
      return data;
    } catch (e) {
      print("Error fetching SharedPreferences: $e");
      return Future.error(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      nama = "Guest";
      pfp = "";
      email = "Please log In";
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }

        pfp = snapshot.data!.foto_profil ??
            "https://res.cloudinary.com/daorbrq8v/image/upload/f_auto,q_auto/v1/atma-bakery/r1xujbu1yfoenzked4rc";
        nama = snapshot.data!.nama;
        email = snapshot.data!.email;
        id_role = snapshot.data!.id_role;

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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/bg_profile.png'),
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
                                        backgroundImage: NetworkImage(pfp!)),
                                    SizedBox(height: 2.h),
                                    Text(
                                      "Hi, ${nama ?? "Guest"}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "${email ?? "Please log In"}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white,
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
                          margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Saldo Saya ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          //     Icon(Icons.attach_money, color: Colors.black),
                                        ],
                                      ),
                                      Text(
                                        '${formatRupiah(saldo.toInt())}',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                        ),
                                      ),
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Poin Saya ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          //  Icon(Icons.monetization_on, color: Colors.black),
                                        ],
                                      ),
                                      Text(
                                        '$poin',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                        ),
                                      ),
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
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/konten_profile.png'),
                              fit: BoxFit.cover,
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
                              id_role != null
                                  ? buildRow(
                                      Icons.account_circle, 'Profil Saya', () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfilSayaPage(),
                                        ),
                                      );
                                    })
                                  : Container(),
                              buildRow(Icons.info, 'Tentang Kami', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TentangKamiPage(),
                                  ),
                                );
                              }),
                              id_role == "CUST"
                                  ? buildRow(
                                      Icons.shopping_cart, 'Histori Pemesanan',
                                      () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HistoriPemesananPage(),
                                        ),
                                      );
                                    })
                                  : Container(),
                              buildRow(Icons.library_books, 'Ketentuan', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => KetentuanPage(),
                                  ),
                                );
                              }),
                              buildRow(Icons.security, 'Kebijakan Privasi', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PrivacyPage(),
                                  ),
                                );
                              }),
                              id_role != null
                                  ? buildRow(Icons.logout, 'Logout', () async {
                                      _isLoading = true;
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      FocusManager.instance.primaryFocus!
                                          .unfocus();
                                      String token =
                                          prefs.getString('token').toString();
                                      await userClient.Logout(token);
                                      prefs.remove('token');
                                      _isLoading = false;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const LoginPage(),
                                        ),
                                      );
                                    })
                                  : Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Center(
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  const TextSpan(
                                                    text: "Sudah Punya Akun?",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextSpan(
                                                    text: " Masuk Sekarang",
                                                    style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 15,
                                                        color: Color.fromRGBO(
                                                            90, 175, 220, 1)),
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () => Navigator
                                                              .of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const LoginPage())),
                                                  ),
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
                      ],
                    )),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
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
