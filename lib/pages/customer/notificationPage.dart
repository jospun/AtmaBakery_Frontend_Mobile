import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/data/client/notifikasiClient.dart';
import 'package:p3l_atmabakery/data/notifikasi.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<Notifikasi>> _notifikasiFuture;
  late Future<String?> _userRoleFuture;

  @override
  void initState() {
    super.initState();
    _notifikasiFuture = NotifikasiClient.fetchUserNotifications();
    _userRoleFuture = _getUserRole();
  }

  Future<String?> _getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_role');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Notifikasi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: FutureBuilder<String?>(
        future: _userRoleFuture,
        builder: (context, roleSnapshot) {
          if (roleSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final id_role = roleSnapshot.data;

            if (id_role == 'GUEST') {
              return Center(
                child: Text(
                  'Daftar dan Nikmati Layanan Kami',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                  ),
                ),
              );
            } else {
              return FutureBuilder<List<Notifikasi>>(
                future: _notifikasiFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak Ada Notifikasi',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                        ),
                      ),
                    );
                  } else {
                    List<Notifikasi> notifikasiList = snapshot.data!;
                    return ListView.builder(
                      itemCount: notifikasiList.length,
                      itemBuilder: (context, index) {
                        final notifikasi = notifikasiList[index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.notifications,
                                color: Colors.orange,
                              ),
                              title: Text(
                                notifikasi.title ?? 'No Title',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                notifikasi.body ?? 'No Body',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (index < notifikasiList.length - 1)
                              Divider(
                                thickness: 1,
                              ),
                          ],
                        );
                      },
                    );
                  }
                },
              );
            }
          }
        },
      ),
    );
  }
}
