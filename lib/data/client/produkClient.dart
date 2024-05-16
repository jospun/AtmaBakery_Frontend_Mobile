import 'package:p3l_atmabakery/data/produk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class produkClient {
  static final String url = "api-atma-bakery.vercel.app";

  static Future<List<Produk>> fetchProduk() async {
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
}
