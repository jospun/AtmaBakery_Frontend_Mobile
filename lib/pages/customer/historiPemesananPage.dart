import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/client/userHistoryClient.dart';
import 'package:p3l_atmabakery/data/userHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriPemesananPage extends StatefulWidget {
  const HistoriPemesananPage({Key? key}) : super(key: key);

  @override
  State<HistoriPemesananPage> createState() => _HistoriPemesananPage();
}

class _HistoriPemesananPage extends State<HistoriPemesananPage> {
  List<UserHistory>? userHistories;
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
    } catch (e) {
      print("Error fetching user history: $e");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Transaksi'),
        ),
        body: ListView.builder(
          itemCount: userHistories!.length,
          itemBuilder: (context, index) {
            final detailTransaksi = userHistories![index].detailTransaksi;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var detailTrans in detailTransaksi!)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Produk: ${detailTrans.id_produk ?? "N/A"}'),
                      Text('Jumlah: ${detailTrans.jumlah ?? "N/A"}'),
                      const Divider(), // Belum fix nanti yaa ehehe
                    ],
                  ),
              ],
            );
          },
        ),
      );
    }
  }
}
