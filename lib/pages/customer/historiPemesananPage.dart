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
  List<UserHistory>? filteredUserHistories;

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
      filteredUserHistories = List.from(userHistories!); 
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

  void _searchByNamaProduk(String namaProduk) {
    setState(() {
      filteredUserHistories = userHistories!.where((history) {
        return history.detailTransaksi1!.any((detail) =>
            detail.nama_produk!.toLowerCase().contains(namaProduk.toLowerCase()));
      }).toList();
    });
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
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Riwayat Pesanan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_circle_left_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: 30,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  filteredUserHistories = List.from(userHistories!);
                });
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Produk',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  _searchByNamaProduk(value);
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
          child: ListView.builder(
            itemCount: filteredUserHistories?.length ?? 0,
            itemBuilder: (context, index) {
              final userHistory = filteredUserHistories![index];
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
                    userDetailHistories =
                        await userHistoryClient.showDetailHistory(userHistory);
                    print(userDetailHistories!.detailTransaksi);
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
                                    '${userHistory.detailTransaksi1 != null && userHistory.detailTransaksi1!.isNotEmpty ? '${userHistory.detailTransaksi1![0].nama_produk ?? 'N/A'}' : 'N/A'}',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  if (userHistory.detailTransaksi1 != null && userHistory.detailTransaksi1!.length != 1)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+${userHistory.detailTransaksi1!.length - 1}',
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
