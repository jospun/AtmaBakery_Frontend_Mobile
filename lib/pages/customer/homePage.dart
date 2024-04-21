import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  User? currentUser;
  bool _isLoading = true;
  String? nama, email, id_role;

  void getUserData() async {
    _isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      currentUser = await userClient.showSelf();
      setState(() {
        nama = currentUser!.nama;
        email = currentUser!.email;
        id_role = currentUser!.id_role;
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
        id_role = null;
      });
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isLoading
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hi, $nama"),
                  Text("Hi, $id_role"),
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
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
