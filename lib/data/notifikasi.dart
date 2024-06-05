import 'dart:convert';

class Notifikasi {
  final int? id_notifikasi;
  final int? id_user;
  final String? title;
  final String? body;

  Notifikasi({
    this.id_notifikasi,
    this.id_user,
    this.title,
    this.body,
  });

  factory Notifikasi.fromRawJson(String str) => Notifikasi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notifikasi.fromJson(Map<String, dynamic> json) => Notifikasi(
        id_notifikasi: json["id_notifikasi"],
        id_user: json["id_user"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id_notifikasi": id_notifikasi,
        "id_user": id_user,
        "title": title,
        "body": body,
      };
}
