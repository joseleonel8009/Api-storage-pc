import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';

downloadFile(String url, String name, String path) async {
  var extStorage = await ExtStorage.getExternalStoragePublicDirectory(
      ExtStorage.DIRECTORY_DOWNLOADS);

  Dio dio = Dio();
  File file = File(extStorage + "/$name");

  Response res = await dio.get(url + "download/$path/$name",
      options: Options(
        responseType: ResponseType.bytes,
      ), onReceiveProgress: (rec, total) {
    print("Descargando ${((rec / total) * 100).toStringAsFixed(0)}%");
    // key.currentState.showSnackBar(snackBar(
    //     "Descargando ${((rec / total) * 100).toStringAsFixed(0)}%",
    //     SnackBarBehavior.fixed));
  });
  RandomAccessFile ref = file.openSync(mode: FileMode.write);
  ref.writeFromSync(res.data);
  await ref.close();
  // await http.get(url + "download/$path/$name");
}
