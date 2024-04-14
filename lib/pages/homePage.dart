import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';

class HomePage extends StatefulWidget {
  final LoginModel loggedIn;
  const HomePage({super.key, required this.loggedIn});

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
          Text(widget.loggedIn.email.toString()),
        ],
      ),
    );
  }
}
