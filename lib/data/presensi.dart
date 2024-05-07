import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Presensi {
  final int? id, status;

  String? email, nama, no_telp;

  Presensi({
    this.id,
    this.email,
    this.nama,
    this.no_telp,
    this.status,
  });

  factory Presensi.fromRawJson(String str) =>
      Presensi.fromJson(json.decode(str));

  factory Presensi.fromJson(Map<String, dynamic> json) => Presensi(
      id: json["id_presensi"],
      email: json["email"],
      nama: json["nama"],
      no_telp: json["no_telp"],
      status: json["status"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_presensi": id.toString(),
        "email": email,
        "nama": nama,
        "no_telp": no_telp,
        "status": status,
      };
}
