import 'dart:convert';
import 'package:app/Api/Api.dart';
import 'package:app/widgets/components/SnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';

class ApiResponseBLoC extends ChangeNotifier {
  // List dirs;
  // List files;
  // List total;
  // String path;
  Api api;
  String progress;
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

  Future<void> downloadFile(String url, String name, String path,
      GlobalKey<ScaffoldState> key) async {
    var extStorage = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);

    Dio dio = Dio();
    File file = File(extStorage + "/$name");

    Response res = await dio.get(url + "download/$path/$name",
        options: Options(
          responseType: ResponseType.bytes,
        ));
    RandomAccessFile ref = file.openSync(mode: FileMode.write);
    ref.writeFromSync(res.data);
    await ref.close();
    key.currentState.showSnackBar(snackBar(
        "Archivo descargado en el dispositivo", SnackBarBehavior.fixed));
    notifyListeners();
    // await http.get(url + "download/$path/$name");
  }

  // Future<dynamic> loadFile(String path, String name) async {
  //   try {
  //     http.Response response = await http.get(initialUrl + path + "/" + name);
  //     var deco = jsonDecode(response.body);
  //     api = Api.fromJson(deco);
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     notifyListeners();
  //   }
  // }
}
