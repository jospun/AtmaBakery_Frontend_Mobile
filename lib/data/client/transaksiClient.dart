import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TransaksiClient {
  static final String url = "api-atma-bakery.vercel.app"; // Sesuaikan dengan URL API Anda

  static Future<Map<String, dynamic>> updateStatusSelesaiSelf(String noNota) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')!;
      
      var response = await http.post(
        Uri.parse("https://$url/update/transaksi/self"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        },
        body: jsonEncode({'no_nota': noNota}),
      ).timeout(const Duration(seconds: 5));

      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["message"]);
      }

      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
