import 'dart:convert';
import 'package:app/Api/Api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiResponseBLoC extends ChangeNotifier {
  // List dirs;
  // List files;
  // List total;
  // String path;
  Api api;
  String initialUrl = "http://192.168.1.3:3000/";

  Future<dynamic> getData(String path) async {
    try {
      http.Response response =
          await http.get(path == null ? initialUrl : initialUrl + path);
      var decoded = jsonDecode(response.body);
      api = Api.fromJson(decoded);
      // dirs = api.content.directories;
      // files = api.content.files;
      // total = api.content.all;
      // path = api.path.replaceAll("\\", "--");
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }
}
