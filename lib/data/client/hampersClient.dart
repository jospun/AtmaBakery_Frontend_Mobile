import 'package:p3l_atmabakery/data/produk.dart';
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

  static Future<Hampers> fetchDetailHampers(id) async {
    try {
      var response =
          await get(Uri.parse("https://$url/hampers/${id}"), headers: {
        "Content-Type": "application/json",
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }

      var responseData = jsonDecode(response.body)["data"];
      var hampers = Hampers.fromJson(responseData);
      return hampers;
    } catch (e) {
      throw Exception(e.toString());
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

  static Future<List<Produk>> countTransaksiHampers(
      id, DateTime tanggal) async {
    final Map<String, dynamic> data = {
      'id_hampers': id,
      'po_date': tanggal.toIso8601String(),
    };
    try {
      var response =
          await post(Uri.parse("https://$url/transaksi/hampers/count"),
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: jsonEncode(data))
              .timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)["data"]);
      }
      List<dynamic> jsonData = jsonDecode(response.body)["data"];
      print(jsonData);
      List<Produk> listProduk =
          jsonData.map((data) => Produk.fromJson(data)).toList();
      print(listProduk);
      return listProduk;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
