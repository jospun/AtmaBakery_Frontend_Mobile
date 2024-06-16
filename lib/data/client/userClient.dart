import 'dart:convert';

import 'package:http/http.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userClient {
  static final String url = "api-atma-bakery.vercel.app"; // ini pake emu yaa

  static Future<String> Login(
      String email, String password, String? fcmToken) async {
    try {
      var response = await post(Uri.parse("https://$url/login"),
          headers: {"Content-Type": "application/json", "is-mobile": "true"},
          body: jsonEncode(
              {"email": email, "password": password, "fcm": fcmToken}));

      if (response.statusCode != 200)
        throw Exception(jsonDecode(response.body)['message'].toString());

      dynamic responseBody = json.decode(response.body)['data'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (responseBody['foto_profil'] != null) {
        prefs.setString("foto_profil", responseBody['foto_profil'].toString());
      }

      prefs.setString('id_role', responseBody['id_role'].toString());
      prefs.setString('email', responseBody['email'].toString());
      prefs.setString('nama', responseBody['nama'].toString());
      prefs.setDouble('saldo', responseBody['saldo'].toDouble());
      prefs.setInt('poin', responseBody['poin'].toInt());

      return json.decode(response.body)['token'].toString();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<String> Logout(String token) async {
    try {
      var response = await post(Uri.parse("https://$url/logout"), headers: {
        "Content-Type": "application/json",
        "is-mobile": "true",
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode != 200)
        throw Exception(jsonDecode(response.body)['message'].toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return json.decode(response.body)['message'].toString();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> sendEmailForResetPassword(String email) async {
    try {
      var response = await post(Uri.parse("https://$url/password/email"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"email": email}));
      if (response.statusCode != 200)
        throw Exception(jsonDecode(response.body)['message'].toString());
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
          body: user.toRawJsonRegister());
      if (response.statusCode != 200)
        throw Exception(jsonDecode(response.body)['message'].toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  static Future<User> showSelf() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token')?.toString();

      if (token == null) throw Exception("Token not found");

      var response = await get(
        Uri.parse("https://$url/users/self"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 5));

      dynamic responseBody = json.decode(response.body)['data'];

      if (responseBody['foto_profil'] != null) {
        prefs.setString("foto_profil", responseBody['foto_profil'].toString());
      } else {
        prefs.remove("foto_profil");
      }

      prefs.setString('id_role', responseBody['id_role'].toString());
      prefs.setString('email', responseBody['email'].toString());
      prefs.setString('nama', responseBody['nama'].toString());
      prefs.setDouble('saldo', responseBody['saldo'].toDouble());
      prefs.setInt('poin', responseBody['poin'].toInt());

      if (response.statusCode != 200)
        throw Exception(jsonDecode(response.body)['message'].toString());

      return User.fromJson(jsonDecode(response.body)["data"]);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> update(User user, String token) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var request = await MultipartRequest(
        'POST',
        Uri.parse("https://$url/users/self"),
      );

      request.headers.addAll({
        "Authorization": 'Bearer $token',
      });

      // Add fields
      if (user.nama != null) {
        request.fields['nama'] = user.nama!;
        prefs.setString('nama', request.fields['nama']!);
      }
      if (user.no_telp != null) request.fields['no_telp'] = user.no_telp!;
      if (user.tanggal_lahir != null)
        request.fields['tanggal_lahir'] = user.tanggal_lahir!;
      if (user.jenis_kelamin != null)
        request.fields['jenis_kelamin'] = user.jenis_kelamin!;
      if (user.id_role != null) {
        request.fields['id_role'] = user.id_role!;
        prefs.setString('id_role', request.fields['id_role']!);
      }
      if (user.email != null) {
        request.fields['email'] = user.email!;
        prefs.setString('email', request.fields['email']!);
      }
      if (user.id != null) request.fields['id_user'] = user.id.toString();

      if (user.foto_profil == null) {
        delete(Uri.parse("https://$url/users/self/pfp"), headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer $token',
        });
        prefs.remove("foto_profil");
      }

      // Add file if present
      if (user.foto_profil_upload != null) {
        request.files.add(
          await MultipartFile.fromPath(
            'foto_profil',
            user.foto_profil_upload!.path,
            filename: 'foto_profil_upload.png',
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode != 200)
        throw Exception(jsonDecode(response.stream.toString()).toString());

      return Response.fromStream(response);
    } catch (e) {
      print(e.toString());
      return Future.error(e.toString());
    }
  }
}
