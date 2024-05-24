import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoriSaldoClient {
  static final String url = "api-atma-bakery.vercel.app";

  static Future<Map<String, dynamic>> fetchSaldoHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse("https://$url/histori_saldo"),
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

  static Future<Map<String, dynamic>> addSaldoHistory(Map<String, dynamic> payload) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.post(
        Uri.parse("https://$url/histori-saldo"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
        body: json.encode(payload),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
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
}
