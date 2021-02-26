import 'package:http/http.dart' as http;

upload(String url, path, pathFile) async {
  var urlUri = Uri.parse(url + "upload/$path");
  http.MultipartRequest request = new http.MultipartRequest("POST", urlUri);
  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('file', pathFile);
  request.files.add(multipartFile);
  await request.send();
}
