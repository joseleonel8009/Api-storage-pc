import 'package:app/Functions/downloadFunction.dart';
import 'package:app/widgets/components/SnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Widget bottomSheet(BuildContext context, String name, url, nameFile, path,
    GlobalKey<ScaffoldState> key) {
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
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).shadowColor,
              ),
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
                try {
                  downloadFile(url, name, path);
                  key.currentState.showSnackBar(snackBar(
                      "Archivo descargado en el dispositivo",
                      SnackBarBehavior.fixed));
                } catch (e) {
                  print(e);
                  key.currentState.showSnackBar(snackBar(
                      "Error al descargar el archivo", SnackBarBehavior.fixed));
                }
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
                  await http.post(url + "delete/$path/$name");
                  key.currentState.showSnackBar(
                      snackBar("Archivo aliminado", SnackBarBehavior.fixed));
                } catch (e) {
                  print(e.message);
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
