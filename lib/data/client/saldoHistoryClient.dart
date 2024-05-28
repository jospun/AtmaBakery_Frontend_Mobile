import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoriSaldoClient {
  static final String url = "api-atma-bakery.vercel.app";

  static Future<Map<String, dynamic>> fetchSaldoHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse("https://$url/histori_saldo/self"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  static Future<Response> create(
      double saldo, String nama_bank, String no_rek) async {
    final Map<String, dynamic> data = {
      'saldo': saldo.toInt(),
      'nama_bank': nama_bank,
      'no_rek': no_rek
    };
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.post(
        Uri.parse("https://$url/histori_saldo"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
        body: jsonEncode(data),
      );

      if (response.statusCode != 200)
        throw Exception(jsonDecode(response.body)['message'].toString());

      print("Response: ${response.body}");
      return response;
    } catch (e) {
      print("Error: $e");
      return Future.error(e.toString());
    }
  }
}
