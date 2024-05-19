import 'dart:math';

import 'package:p3l_atmabakery/data/produk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class produkClient {
  static final String url = "api-atma-bakery.vercel.app";

  static Future<List<dynamic>> fetchProduk() async {
    try {
      var response = await get(Uri.parse("https://$url/produk"), headers: {
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }

      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      List<Produk> listProduk =
          jsonData.map((data) => Produk.fromJson(data)).toList();
      print(listProduk);
      return listProduk;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<dynamic>> searchProduk(String search) async {
    final Map<String, dynamic> data = {
      'data': search,
    };
    try {
      var response = await post(
        Uri.parse("https://$url/produk/search"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 5));

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }

      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      List<Produk> listProduk =
          jsonData.map((data) => Produk.fromJson(data)).toList();
      print(listProduk);
      return listProduk;
    } catch (e) {
      print("Error fetching products: $e");
      return Future.error(e.toString());
    }
  }

  static Future<int> countTransaksi(id, DateTime tanggal) async {
    final Map<String, dynamic> data = {
      'id_produk': id,
      'po_date': tanggal.toIso8601String(),
    };
    try {
      var response = await post(
        Uri.parse("https://$url/transaksi/count"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 5));

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }

      int jsonData = jsonDecode(response.body)["data"]["remaining"];

      print(jsonData);
      return jsonData;
    } catch (e) {
      print("Error fetching transaksi count: $e");
      return Future.error(e.toString());
    }
  }
}
