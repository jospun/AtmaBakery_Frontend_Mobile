import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:p3l_atmabakery/data/client/userHistoryClient.dart';
import 'package:p3l_atmabakery/data/userHistory.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/pages/customer/detailTransaksiPage.dart';
import 'package:p3l_atmabakery/formatter.dart';

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
        return history.detailTransaksi1!.any((detail) => detail.nama_produk!
            .toLowerCase()
            .contains(namaProduk.toLowerCase()));
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
                  title: Row(
          children: [
            Expanded(
              child: Text(
                "Riwayat Pesanan",
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
bottom: PreferredSize(
  preferredSize: Size.fromHeight(60.0),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.0), 
    child: Container(
      height: 60.0,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari Produk',
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: (value) {
          _searchByNamaProduk(value);
        },
      ),
    ),
  ),
),

        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
          child: ListView.builder(
            itemCount: filteredUserHistories?.length ?? 0,
            itemBuilder: (context, index) {
              final userHistory = filteredUserHistories![index];
              Color badgeColor = Colors.grey;
              String statusText = userHistory.status!;
              if (userHistory.status == 'Pesanan Diterima' ||
                  userHistory.status == 'Selesai' ||
                  userHistory.status == 'Terkirim') {
                badgeColor = Colors.green;
              } else if (userHistory.status == 'Ditolak') {
                badgeColor = Colors.red;
              } else if (
                  userHistory.status == 'Siap Pick Up' ||
                  userHistory.status == 'Siap Kirim'   ||
                  userHistory.status == 'Sedang Diantar Kurir' ||
                  userHistory.status == 'Sedang Diantar Ojol' 
                  ) {
                badgeColor = Colors.blue;
              } else if (userHistory.status == 'Sedang Di Proses'){
                badgeColor = Colors.yellow;
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
                                  Container(
                                    child: AutoSizeText(
                                      '${userHistory.detailTransaksi1 != null && userHistory.detailTransaksi1!.isNotEmpty ? 
                                        (userHistory.detailTransaksi1![0].nama_produk != null && userHistory.detailTransaksi1![0].nama_produk!.length > 15 ? 
                                          '${userHistory.detailTransaksi1![0].nama_produk!.substring(0, 15)}...' : 
                                          userHistory.detailTransaksi1![0].nama_produk) : 'N/A'}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  if (userHistory.detailTransaksi1 != null && userHistory.detailTransaksi1!.length > 1)
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
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
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
                                '${formatRupiah(userHistory.total ?? 0)}',
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
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
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
                                formatTanggalWaktu(
                                    userHistory.tanggal_pesan ?? 'N/A'),
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 15),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: badgeColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  statusText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
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
