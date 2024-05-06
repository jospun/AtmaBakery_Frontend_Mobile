import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/client/userHistoryClient.dart';
import 'package:p3l_atmabakery/data/userHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/pages/customer/detailTransaksiPage.dart';
import 'package:intl/intl.dart';

class HistoriPemesananPage extends StatefulWidget {
  const HistoriPemesananPage({Key? key}) : super(key: key);

  @override
  State<HistoriPemesananPage> createState() => _HistoriPemesananPage();
}

class _HistoriPemesananPage extends State<HistoriPemesananPage> {
  List<UserHistory>? userHistories;
  UserHistory? userDetailHistories;

  bool _isLoading = true;

  String formatRupiah(int amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(amount);
  }

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  Future<void> _loadHistoryData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    try {
      userHistories = await userHistoryClient.showHistorySelf();
    } catch (e) {
      print("Error fetching user history: $e");
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToDetail(UserHistory userHistory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailTransaksiPage(userHistory: userHistory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Riwayat Pesanan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 4,
          shadowColor: Colors.grey,
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: ListView.builder(
            itemCount: userHistories?.length ?? 0,
            itemBuilder: (context, index) {
              final userHistory = userHistories![index];
              Color badgeColor = Colors.grey;
              String statusText = 'Menunggu Pembayaran';
              if (userHistory.status == 'Terkirim') {
                badgeColor = Colors.green;
                statusText = 'Terkirim';
              } else if (userHistory.status == 'Dibatalkan') {
                badgeColor = Colors.red;
                statusText = 'Dibatalkan';
              }

              return GestureDetector(
                onTap: () async {
                  try {
                    userDetailHistories = await userHistoryClient.showDetailHistory(userHistory);
                    _navigateToDetail(userDetailHistories!); 
                  } catch (e) {
                    print("Error fetching user history: $e");
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${userHistory.detailTransaksi != null && userHistory.detailTransaksi!.isNotEmpty ? '${userHistory.detailTransaksi![0].nama_produk ?? 'N/A'}' : 'N/A'}',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  if (userHistory.detailTransaksi != null && userHistory.detailTransaksi!.length != 1)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+${userHistory.detailTransaksi!.length - 1}',
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 25),
                              Text(
                                'Total Harga',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${formatRupiah( userHistory.total ?? 0)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No. ${userHistory.no_nota ?? 'N/A'}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tanggal Pesan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                userHistory.tanggal_pesan ?? 'N/A',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: badgeColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  statusText,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
