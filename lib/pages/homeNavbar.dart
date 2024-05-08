import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/pages/MO/laporanPage.dart';
import 'package:p3l_atmabakery/pages/customer/homePage.dart';
import 'package:p3l_atmabakery/pages/customer/notificationPage.dart';
import 'package:p3l_atmabakery/pages/customer/produkPage.dart';
import 'package:p3l_atmabakery/pages/customer/profilePage.dart';
import 'package:p3l_atmabakery/pages/MO/presensiPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({Key? key}) : super(key: key);

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  User? currentUser;
  bool _isLoading = true;
  String? nama, email;
  String? id_role;
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id_role = prefs.getString('id_role');
    email = prefs.getString('email');
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      currentUser = await userClient.showSelf();
      setState(() {
        nama = currentUser!.nama;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching SharedPreferences: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) async {
    main();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator(); // Show loading indicator
    }

    _widgetOptions = (id_role == "CUST" || id_role == null)
        ? <Widget>[
            const HomePage(),
            const ProdukPage(),
            const NotificationPage(),
            const ProfilePage(),
          ]
        : <Widget>[
            const HomePage(),
            const PresensiPage(),
            const LaporanPage(),
            const ProfilePage(),
          ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: (id_role == "CUST" || id_role == null)
            ? const [
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
              ]
            : const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.date_range),
                  label: 'Presensi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: 'Laporan',
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
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
