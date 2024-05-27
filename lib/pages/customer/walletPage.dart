import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/formatter.dart';
import 'package:p3l_atmabakery/pages/customer/tarikWalletPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/data/client/saldoHistoryClient.dart';
import 'package:p3l_atmabakery/data/saldoHistory.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPage();
}

class _WalletPage extends State<WalletPage> {
  String nama = 'Nama User';
  double saldo = 0.0;
  late Future<List<SaldoHistory>>? saldoHistoryFuture;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    saldoHistoryFuture = _fetchSaldoHistory();
  }

  Future<void> _loadUserData() async {
    try {
      User prefs = await userClient.showSelf();
      setState(() {
        nama = prefs.nama!;
        saldo = prefs.saldo!;
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<List<SaldoHistory>> _fetchSaldoHistory() async {
    try {
      var result = await HistoriSaldoClient.fetchSaldoHistory();
      if (result['success']) {
        List<SaldoHistory> saldoHistoryList = [];
        for (var i = result['data'].length - 1; i >= 0; i--) {
          saldoHistoryList.add(SaldoHistory.fromJson(result['data'][i]));
        }
        return saldoHistoryList;
      } else {
        throw Exception(result['message']);
      }
    } catch (e) {
      throw Exception('Error fetching saldo history: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: Text(
                "Dompet Saya",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 4 / 2,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg_wallet.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatRupiah(saldo.toInt()),
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
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_box_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '$nama',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.bakery_dining,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Atma Bakery',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
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
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Aksi Transfer',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.account_balance,
                    label: 'Penarikan Saldo',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TarikWalletPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Riwayat Penarikan',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<List<SaldoHistory>>(
                future: saldoHistoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<SaldoHistory> saldoHistoryList = snapshot.data!;
                    return Container(
                      height: 430, 
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: saldoHistoryList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              saldoHistoryList[index].tanggal ?? 'Menunggu Konfirmasi',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                color: saldoHistoryList[index].tanggal == null ? Colors.blue : Colors.black,
                              ),
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    saldoHistoryList[index].namaBank,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: saldoHistoryList[index].namaBank == null ? Colors.blue : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'No. Rek ${saldoHistoryList[index].noRek}',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            trailing: Text(
                              '${formatRupiahDouble(saldoHistoryList[index].saldo)}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                color: saldoHistoryList[index].saldo == 0.0 ? Colors.blue : Colors.orange,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          label,
          style: TextStyle(fontSize: 13),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 2,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
