// To parse this JSON data, do
//
//     final generalResponseModel = generalResponseModelFromJson(jsonString);

import 'dart:convert';

List<GeneralResponseModel> generalResponseModelFromJson(String str) =>
    List<GeneralResponseModel>.from(
        json.decode(str).map((x) => GeneralResponseModel.fromJson(x)));

String generalResponseModelToJson(List<GeneralResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GeneralResponseModel {
  String message;

  GeneralResponseModel({
    required this.message,
  });

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) =>
      GeneralResponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
