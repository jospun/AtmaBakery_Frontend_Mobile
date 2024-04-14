import 'dart:convert';

class LoginModel {
  String email;

  LoginModel({
    required this.email,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "email": email,
      };
}

class User {
  String email, nama, password, no_telp, password_confirmation;
  String tanggal_lahir;

  User({
    required this.email,
    required this.nama,
    required this.password,
    required this.password_confirmation,
    required this.no_telp,
    required this.tanggal_lahir,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        nama: json["nama"],
        password: json["password"],
        password_confirmation: json["password_confirmation"],
        no_telp: json["no_telp"],
        tanggal_lahir: json["tanggal_lahir"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "email": email,
        "nama": nama,
        "password": password,
        "password_confirmation": password_confirmation,
        "no_telp": no_telp,
        "tanggal_lahir": tanggal_lahir,
      };
}
