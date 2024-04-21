import 'dart:convert';

class User {
  final int? id;

  final String? token;
  String? email, nama, password, no_telp, password_confirmation;
  String? tanggal_lahir, id_role;

  User({
    this.id,
    this.id_role,
    this.token,
    this.email,
    this.nama,
    this.password,
    this.password_confirmation,
    this.no_telp,
    this.tanggal_lahir,
  });

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
      };
}
