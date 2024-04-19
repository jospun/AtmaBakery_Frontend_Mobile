import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  User? currentUser;
  bool _isLoading = true;
  String? nama, email;

  void getUserData() async {
    _isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      currentUser = await userClient.showSelf();
      setState(() {
        nama = currentUser!.nama;
        email = currentUser!.email;
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
                              "https://img.freepik.com/free-vector/abstract-colorful-flow-shapes-background_23-2148236278.jpg?size=626&ext=jpg&ga=GA1.1.1700460183.1708041600&semt=ais"), // Ganti dengan path gambar Anda
                          fit: BoxFit.cover, // Atur sesuai kebutuhan
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
                                  backgroundImage: NetworkImage(
                                      "https://www.bpocenter.com.bo/wp-content/uploads/2017/11/10.jpg"),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  "Hi, $nama",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          FocusManager.instance.primaryFocus!.unfocus();
                          String token = prefs.getString('token').toString();
                          await userClient.Logout(token);
                          prefs.remove('token');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text("Logout")),
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
