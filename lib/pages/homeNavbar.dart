import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/pages/homePage.dart';
import 'package:p3l_atmabakery/pages/notificationPage.dart';
import 'package:p3l_atmabakery/pages/produkPage.dart';
import 'package:p3l_atmabakery/pages/profilePage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({super.key});

  @override
  State<HomeNavbar> createState() => _HomeNavbar();
}

class _HomeNavbar extends State<HomeNavbar> {
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOption = [];

  @override
  void initState() {
    _widgetOption = <Widget>[
      const HomePage(),
      const ProdukPage(),
      const NotificationPage(),
      const ProfilePage(),
    ];
    getUserData();
    if (currentUser == null) {
      setState(() {
        nama = "Guest";
        email = "Please log In";
      });
      _isLoading = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _widgetOption.elementAt(_selectedIndex),
    );
  }
}
