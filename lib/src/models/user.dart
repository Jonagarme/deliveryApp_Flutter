// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
  });

  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"].toString(),
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
      };
}
