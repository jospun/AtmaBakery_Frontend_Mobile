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
