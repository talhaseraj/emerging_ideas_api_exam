// To parse this JSON data, do
//
//     final readResponseModel = readResponseModelFromJson(jsonString);

import 'dart:convert';

List<User> readResponseModelFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String readResponseModelToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int id;
  String title;
  String description;
  String imgLink;
  String email;

  User({
    required this.id,
    required this.title,
    required this.description,
    required this.imgLink,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imgLink: json["img_link"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "img_link": imgLink,
        "email": email,
      };
}
