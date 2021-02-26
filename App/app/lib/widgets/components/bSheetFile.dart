import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

Widget bSheetFile(BuildContext context, String url, dir) {
  var size = MediaQuery.of(context).size;

  return SingleChildScrollView(
    child: Container(
      color: Colors.white,
      height: size.height / 3,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                leading: Icon(
                  Icons.view_array_outlined,
                  color: Colors.blue,
                ),
                title: Text(
                  'Ver Archivo',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.download_sharp,
                  color: Colors.green,
                ),
                title: Text(
                  'Descargar Archivo',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                try {
                  // await http.post(url + "dirRemove/$dirName/$dir");
                } catch (e) {
                  print(e);
                }
                Navigator.pop(context);
              },
              child: ListTile(
                leading: Icon(
                  Icons.restore_from_trash_rounded,
                  color: Colors.red,
                ),
                title: Text(
                  'Borrar Archivo',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10),
            topRight: const Radius.circular(10),
          ),
        ),
      ),
    ),
  );
}
