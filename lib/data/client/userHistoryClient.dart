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
      throw Exception(jsonDecode(response.body)["message"]);
    }

    List<dynamic> jsonData = jsonDecode(response.body)["data"];
    List<UserHistory> userHistories = jsonData.map((data) => UserHistory.fromJson(data)).toList();

    return userHistories;
  } catch (e) {
    return Future.error(e.toString());
  }
}

 static Future<dynamic> showDetailHistory(UserHistory uh) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token')!;
    var response = await post(
      Uri.parse("https://$url/get-nota/self"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token',
      },
      body: uh.toRawJson()
    ).timeout(const Duration(seconds: 5));
    print('Response Body: ${response.body}');
    

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)["data"]);
    }
    var jsonResponse = jsonDecode(response.body)["data"];
    UserHistory userHistory = UserHistory.fromJson(jsonResponse);
    return userHistory;
  } catch (e) {
    return Future.error(e.toString());
  }
}

}
