import 'package:emerging_ideas/models/general_response_model.dart';
import 'package:emerging_ideas/models/read_response_model.dart';
import 'package:emerging_ideas/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' show json, utf8;

class ApiService {
  var client = http.Client;
  Future readUsers() async {
    try {
      var response = await http.get(Uri.parse("${Urls.readUrl}?email=email"));
      var temp = utf8.decode(response.bodyBytes);
      if (kDebugMode) {
        print(temp);
      }
      return readResponseModelFromJson(temp);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }

  Future deleteUser(email, id) async {
    try {
      var response =
          await http.get(Uri.parse("${Urls.deleteUrl}?email=$email&id=$id"));
      var temp = utf8.decode(response.bodyBytes);
      if (kDebugMode) {
        print(temp);
      }
      return generalResponseModelFromJson(temp);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }

  Future editUser(Map<String, String> params, id) async {
    try {
      var response = await http.get(Uri.parse(
        "${Urls.editUrl}?email=${params["email"]}&id=$id&title=${params["title"]}&description=${params["description"]}&img_link=${params["img_link"]}",
      ));
      var temp = utf8.decode(response.bodyBytes);
      if (kDebugMode) {
        print(temp);
      }
      return generalResponseModelFromJson(temp);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }

  Future createUser(Map<String, String> params) async {
    try {
      var response = await http.post(
          Uri.parse(
            Urls.createUrl,
          ),
          body: json.encode(params));
      var temp = utf8.decode(response.bodyBytes);
      if (kDebugMode) {
        print(temp);
      }
      return generalResponseModelFromJson(temp);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return null;
    }
  }
}
