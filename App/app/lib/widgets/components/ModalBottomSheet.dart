// import 'package:app/Functions/downloadFunction.dart';
import 'package:app/Provider/ApiResponseBLoC.dart';
import 'package:app/widgets/components/SnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Widget bottomSheet(BuildContext context, String name, String url,
    String nameFile, String path, GlobalKey<ScaffoldState> key) {
  var size = MediaQuery.of(context).size;
  final bloc = Provider.of<ApiResponseBLoC>(context, listen: true);
  final path = bloc.api.path.replaceAll("\\", "--");

  return SingleChildScrollView(
      child: Container(
    color: Colors.white,
    height: size.height / 2,
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
          Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).shadowColor,
                ),
              ),
              InkWell(
                onTap: () async {
                  try {
                    if (name.endsWith(".png") || name.endsWith(".jpg")) {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        "/fileImage",
                        arguments: <String, String>{
                          'url': url,
                          'path': bloc.api.path.replaceAll("\\", "--"),
                          'fileName': name,
                        },
                      );
                    } else if (name.endsWith(".mp4")) {
                      Navigator.pop(context);
                      /* Abrir en el navegador */
                      var openUrl = "${url}file/$path/$name";
                      if (await canLaunch(openUrl)) {
                        await launch(openUrl,
                            webOnlyWindowName: name, universalLinksOnly: true);
                      } else {
                        key.currentState.showSnackBar(snackBar(
                            "No se puede abrir", SnackBarBehavior.fixed));
                        throw 'No se puede Abrir';
                      }
                      // Navigator.pushNamed(context, "/fileVideo",
                      //     arguments: <String, String>{
                      //       'url': url,
                      //       'path': path,
                      //       'name': name
                      //     });
                    } else if (name.endsWith(".doc") ||
                        name.endsWith(".docx")) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/fileDoc");
                    } else if (name.endsWith(".pdf")) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/filePdf",
                          arguments: <String, String>{
                            'url': url,
                            'path': path,
                            'name': name
                          });
                    } else {
                      key.currentState.showSnackBar(snackBar(
                          "No se puede abrir", SnackBarBehavior.fixed));
                    }
                  } catch (e) {
                    print(e);
                    key.currentState.showSnackBar(snackBar(
                        "Ha ocurrido un error", SnackBarBehavior.fixed));
                  }
                },
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
                    bloc.downloadFile(url, name, path, key);
                    key.currentState.showSnackBar(snackBar(
                        "Descargando Archivo", SnackBarBehavior.fixed));
                  } catch (e) {
                    print(e);
                    key.currentState.showSnackBar(snackBar(
                        "Error al descargar el archivo",
                        SnackBarBehavior.fixed));
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
          )
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
  )
      // : Text("Descargando archivo: ${bloc.progress}"),
      );
}
