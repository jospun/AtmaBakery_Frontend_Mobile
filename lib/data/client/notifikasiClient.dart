import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:p3l_atmabakery/data/notifikasi.dart';

class NotifikasiClient {
  static final String url = "api-atma-bakery.vercel.app";

  static Future<List<Notifikasi>> fetchUserNotifications() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      var response = await http.get(
        Uri.parse("https://$url/get-notif/self/mobile"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["message"]);
      }

      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      List<Notifikasi> listNotifikasi = jsonData.map((data) => Notifikasi.fromJson(data)).toList();
      return listNotifikasi;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
  
}
