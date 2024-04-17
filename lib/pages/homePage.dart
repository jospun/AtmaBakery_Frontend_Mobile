import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("PP"),
          ElevatedButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus!.unfocus();
                userClient.Logout();
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
    );
  }
}
