import 'package:p3l_atmabakery/data/presensi.dart';
import 'package:p3l_atmabakery/data/userHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class presensiClient {
  static final String url = "api-atma-bakery.vercel.app"; // ini pake emu yaa

  static Future<List<Presensi>> showPresensiByDate(String date) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      var response = await get(Uri.parse("https://$url/presensi/date/${date}"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": 'Bearer $token'
          }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }

      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      List<Presensi> listPresensi =
          jsonData.map((data) => Presensi.fromJson(data)).toList();
      print(listPresensi);
      return listPresensi;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updatePresensi(int id, Presensi presensi) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      var response = await put(Uri.parse("https://$url/presensi/${id}"),
              headers: {
                "Content-Type": "application/json",
                "Authorization": 'Bearer $token'
              },
              body: presensi.toRawJson())
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error('error sini ' + e.toString());
    }
  }
}
