import 'package:p3l_atmabakery/data/bahanBaku.dart';
import 'package:p3l_atmabakery/data/laporanPemasukkanPengeluaran.dart';
import 'package:p3l_atmabakery/data/presensi.dart';
import 'package:p3l_atmabakery/data/userHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class laporanClient {
  static final String url = "api-atma-bakery.vercel.app"; // ini pake emu yaa

  static Future<List<BahanBaku>> getBahanBakuNow() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      var response = await get(
          Uri.parse("https://$url/get-laporan-stok-bahan-baku"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $token'
          }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }
      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      print(jsonData);
      List<BahanBaku> listBahanBaku =
          jsonData.map((data) => BahanBaku.fromJson(data)).toList();
      return listBahanBaku;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<BahanBaku>> getBahanBakubyDate(
      DateTime tanggalAwal, DateTime tanggalAkhir) async {
    final Map<String, dynamic> data = {
      'tanggal_awal': tanggalAwal.toIso8601String(),
      'tanggal_akhir': tanggalAkhir.toIso8601String(),
    };

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      var response = await post(
        Uri.parse("https://$url/get-laporan-stok-bahan-baku-periode"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }
      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      print(jsonData);
      List<BahanBaku> listBahanBaku =
          jsonData.map((data) => BahanBaku.fromJson(data)).toList();
      print(listBahanBaku);
      return listBahanBaku;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<dynamic> getPemasukandanPengeluaran(DateTime tanggal) async {
    final Map<String, dynamic> data = {
      'bulan': tanggal.month.toString(),
      'tahun': tanggal.year.toString(),
    };

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      var response = await post(
        Uri.parse("https://$url/get-laporan-pemasukan-dan-pengeluaran"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body));
      }
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);
      return LaporanPemasukkanPengeluaran.fromJson(jsonData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
