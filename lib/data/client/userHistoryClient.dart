import 'package:p3l_atmabakery/data/userHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class userHistoryClient {
  static final String url = "api-atma-bakery.vercel.app"; // ini pake emu yaa

  static Future<List<UserHistory>> showHistorySelf() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      var response = await get(
        Uri.parse("https://$url/transaksi/self/history"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 5));
      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body));
      }

      List<dynamic> jsonDataList = jsonDecode(response.body)["data"];
      List<UserHistory> userHistories =
          jsonDataList.map((data) => UserHistory.fromJson(data)).toList();

      return userHistories;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
