import 'package:flutter/material.dart';
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
  late Future<List<SaldoHistory>>? saldoHistoryFuture; // Menentukan variabel untuk menyimpan data histori saldo

  @override
  void initState() {
    super.initState();
    _loadUserData();
    saldoHistoryFuture = _fetchSaldoHistory(); // Mengambil histori saldo saat inisialisasi widget
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        nama = prefs.getString('nama') ?? 'Nama User';
        saldo = prefs.getDouble('saldo') ?? 0.0;
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
        for (var data in result['data']) {
          saldoHistoryList.add(SaldoHistory.fromJson(data));
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
      body: Padding(
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
                          'Rp ${saldo.toStringAsFixed(2)}',
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
                  icon: Icons.wallet,
                  label: 'Rekening Bank',
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                _buildActionButton(
                  icon: Icons.account_balance,
                  label: 'Penarikan Saldo',
                  onPressed: () {},
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
            // Tambahkan FutureBuilder untuk menampilkan data histori saldo
            FutureBuilder<List<SaldoHistory>>(
              future: saldoHistoryFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<SaldoHistory> saldoHistoryList = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: saldoHistoryList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Tanggal: ${saldoHistoryList[index].tanggal}'),
                        subtitle: Text('Saldo: ${saldoHistoryList[index].saldo}'),
                        trailing: Text('Bank: ${saldoHistoryList[index].namaBank}'),
                      );
                    },
                  );
                }
              },
            ),
          ],
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
