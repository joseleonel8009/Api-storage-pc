import 'package:app/Functions/UploadFunction.dart';
import 'package:app/widgets/components/SnackBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Widget bNewFileOrDir(
    BuildContext context,
    String url,
    path,
    GlobalKey<ScaffoldState> scaffoldKey,
    GlobalKey<FormState> formKey,
    bool finish) {
  var size = MediaQuery.of(context).size;
  var name;

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
              onTap: () async {
                Navigator.pop(context);
                try {
                  FilePickerResult result = await FilePicker.platform
                      .pickFiles(type: FileType.custom, allowedExtensions: [
                    'jpg',
                    'pdf',
                    'docx',
                    'doc',
                    'png',
                    'mp4',
                  ]);
                  if (result != null) {
                    PlatformFile file = result.files.single;
                    /* Funcion para subir archivos */
                    upload(url, path, file.path);

                    // showSnackBar
                    scaffoldKey.currentState.showSnackBar(snackBar(
                      "${file.name} se ha subido",
                      SnackBarBehavior.fixed,
                    ));
                  } else {
                    // User canceled the picker
                    print("el usuario no subio nada");
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: ListTile(
                leading: Icon(
                  Icons.upload_file,
                  color: Colors.blue,
                ),
                title: Text(
                  'Subir Archivo',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            finish == false
                ? InkWell(
                    onTap: () async {
                      try {
                        await showModalBottomSheet(
                          context: context,
                          builder: (_) => SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              height: size.height,
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
                                    Form(
                                      key: formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: TextFormField(
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            errorStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                            labelText: "Nombre para la capeta",
                                            labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                            contentPadding: EdgeInsets.all(12),
                                            hintText: "Nombre para la carpeta",
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.7)),
                                            prefixIcon: Icon(Icons.folder,
                                                color: Theme.of(context)
                                                    .accentColor),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.2))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.5))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .focusColor
                                                        .withOpacity(0.2))),
                                          ),
                                          keyboardType: TextInputType.text,
                                          validator: (value) => value.isEmpty
                                              ? "Debe tener almenos 1 caracter"
                                              : null,
                                          onSaved: (value) {
                                            name = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    MaterialButton(
                                      color: Theme.of(context).accentColor,
                                      child: Text(
                                        "Crear Carpeta",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();
                                          try {
                                            await http.post(
                                                url + "dirCreate/$path/$name");
                                            Navigator.pop(context);
                                            scaffoldKey.currentState
                                                .showSnackBar(snackBar(
                                                    "Carpeta creada con nombre $name",
                                                    SnackBarBehavior.fixed));
                                          } catch (e) {
                                            print(e);
                                          }
                                        }
                                      },
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
                            ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.create_new_folder_rounded,
                        color: Colors.green,
                      ),
                      title: Text(
                        'Crear carpeta',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  )
                : Center(
                    child: Text("Ya no puedes crear mas carpetas"),
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
