import 'package:p3l_atmabakery/data/produk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

class hampersClient {
  static final String url = "api-atma-bakery.vercel.app";

  static Future<List<dynamic>> fetchHampers() async {
    try {
      var response = await get(Uri.parse("https://$url/hampers"), headers: {
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }

      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      List<Hampers> listHampers =
          jsonData.map((data) => Hampers.fromJson(data)).toList();
      print(listHampers);
      return listHampers;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<dynamic>> searchHampers(String temp) async {
    final Map<String, dynamic> data = {
      'data': temp,
    };
    try {
      var response = await post(Uri.parse("https://$url/hampers/search"),
              headers: {
                "Content-Type": "application/json",
              },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }

      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      List<Hampers> listHampers =
          jsonData.map((data) => Hampers.fromJson(data)).toList();
      print(listHampers);
      return listHampers;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
