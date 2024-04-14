import 'package:p3l_atmabakery/data/user.dart';

import 'dart:convert';
import 'package:http/http.dart';

class userClient {
  static final String url =
      "api-atma-bakery.vercel.app/api"; // ini pake emu yaa

  static Future<LoginModel> Login(String email, String password) async {
    try {
      var response = await post(Uri.parse("https://$url/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email, "password": password}));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return LoginModel.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> sendEmailForResetPassword(String email) async {
    try {
      var response = await post(Uri.parse("https://$url/password/email"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email}));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  static Future<Response> create(User user) async {
    try {
      var response = await post(Uri.parse("https://$url/register"),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
