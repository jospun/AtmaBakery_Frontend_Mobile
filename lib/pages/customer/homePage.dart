import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? nama, email, id_role, profilePictureUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userClient.showSelf(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hi, Guest"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          );
        }

        User user = snapshot.data as User;
        nama = user.nama;
        id_role = user.id_role;
        profilePictureUrl = user.foto_profil;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat Datang",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Halo, $nama",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(profilePictureUrl ?? ''),
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rp 00000',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Saldo Saya',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.wallet,
                                  color: Colors.white,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Penarikan Saldo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Colors.white,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Riwayat Saldo',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Produk',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BulletButton(
                      icon: Icons.shopping_bag_outlined,
                      label: 'Produk',
                      onPressed: () {},
                    ),
                    BulletButton(
                      icon: Icons.info_outline,
                      label: 'Informasi',
                      onPressed: () {},
                    ),
                    BulletButton(
                      icon: Icons.notification_add_outlined,
                      label: 'Notifikasi',
                      onPressed: () {},
                    ),
                    BulletButton(
                      icon: Icons.history_edu_outlined,
                      label: 'Pemesanan',
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Text("Produk Terbaru",
                   style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BulletButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const BulletButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 232, 210),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.orange,
              size: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
