import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class User {
  final int? id;

  final String? token;
  String? email, nama, password, no_telp, password_confirmation;
  String? tanggal_lahir, id_role;
  String? jenis_kelamin;
  String? foto_profil;
  double? saldo;
  XFile? foto_profil_upload;

  User(
      {this.id,
      this.id_role,
      this.token,
      this.email,
      this.nama,
      this.password,
      this.password_confirmation,
      this.no_telp,
      this.tanggal_lahir,
      this.jenis_kelamin,
      this.foto_profil,
      this.saldo});

  User.toUpload(
      {this.id,
      this.id_role,
      this.token,
      this.email,
      this.nama,
      this.password,
      this.password_confirmation,
      this.no_telp,
      this.tanggal_lahir,
      this.jenis_kelamin,
      this.foto_profil,
      this.foto_profil_upload});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id_user"],
        id_role: json["id_role"],
        token: json["token"],
        email: json["email"],
        nama: json["nama"],
        password: json["password"],
        password_confirmation: json["password_confirmation"],
        no_telp: json["no_telp"],
        tanggal_lahir: json["tanggal_lahir"],
        jenis_kelamin: json["jenis_kelamin"],
        foto_profil: json["foto_profil"],
        saldo: json["saldo"].toDouble(),
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_user": id.toString(),
        "id_role": id_role,
        "token": token,
        "email": email,
        "nama": nama,
        "password": password,
        "password_confirmation": password_confirmation,
        "no_telp": no_telp,
        "tanggal_lahir": tanggal_lahir,
        "jenis_kelamin": jenis_kelamin,
        "foto_profil": File(foto_profil_upload!.path),
        "saldo": saldo,
      };
}
