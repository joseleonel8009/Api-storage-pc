import 'dart:convert';
import 'package:app/Api/Api.dart';
import 'package:app/Provider/ApiResponseBLoC.dart';
import 'package:app/widgets/components/ModalBottomSheet.dart';
import 'package:app/widgets/components/SnackBar.dart';
import 'package:app/widgets/components/bNewFileOrDir.dart';
import 'package:app/widgets/components/imgFile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
  String path;
    setState(() {
      path = api.path;
    });

    print(widget.url + path);
  Este metodo es para obtener la url sin escribirla solo extrayendola de la api.
  Para usarla necesitaremos concatenar url + path y  nos daria la url nueva
*/

class CarpetaSubScreen extends StatefulWidget {
  final String dirName;
  final String beforeName;

  CarpetaSubScreen({this.dirName, this.beforeName});

  // // nuevo
  // static Widget init(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (_) => ApiResponseBLoC(),
  //     builder: (_, __) => CarpetaSubScreen(),
  //   );
  // }

  @override
  _CarpetaSubScreenState createState() => _CarpetaSubScreenState();
}

class _CarpetaSubScreenState extends State<CarpetaSubScreen> {
  // Api api;
  Api content;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // loadData();
  //     // Provider.of<ApiResponseBLoC>(context, listen: false)
  //     //   ..getData(widget.beforeName + widget.dirName + widget.beforeName);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiResponseBLoC>(
      create: (_) => ApiResponseBLoC()
        ..getData(widget.beforeName + widget.dirName + widget.beforeName),
      child: Consumer<ApiResponseBLoC>(
        builder: (context2, bloc, _) {
          var size = MediaQuery.of(context2).size;
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color(0xFF329d9c),
              title: Text(widget.dirName),
              leading: IconButton(
                tooltip: "Volver",
                onPressed: () {
                  Navigator.pop(context2);
                },
                icon: Icon(Icons.arrow_back),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  tooltip: "Refrescar",
                  onPressed: () {
                    // loadData();
                    bloc.getData(
                        widget.beforeName + widget.dirName + widget.beforeName);
                    _scaffoldKey.currentState.showSnackBar(
                        snackBar("Refrescado", SnackBarBehavior.fixed));
                  },
                )
              ],
            ),
            body: bloc.api == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : bloc.api.content == null
                    ? Center(
                        child: Text("No hay datos"),
                      )
                    : FutureBuilder(
                        future: bloc.getData(widget.beforeName +
                            widget.dirName +
                            widget.beforeName),
                        builder: (context3, snapshot) {
                          return GridView.count(
                              physics: BouncingScrollPhysics(),
                              crossAxisCount: 2,
                              children: bloc.api.content.all.map((allCon) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (allCon.endsWith(".mp4") ||
                                          allCon.endsWith(".doc") ||
                                          allCon.endsWith(".png") ||
                                          allCon.endsWith(".jpg") ||
                                          allCon.endsWith(".pdf") ||
                                          allCon.endsWith(".docx")) {
                                        showModalBottomSheet(
                                            context: context3,
                                            builder: (_) => bottomSheet(
                                                context3,
                                                allCon,
                                                bloc.initialUrl,
                                                allCon,
                                                widget.dirName,
                                                _scaffoldKey));
                                      } else if (allCon.contains(".ini")) {
                                        showModalBottomSheet(
                                            context: context3,
                                            builder: (_) =>
                                                SingleChildScrollView(
                                                  child: Container(
                                                    color: Colors.white,
                                                    height: size.height / 3,
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .close),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context3);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          Center(
                                                            child: Text(
                                                                "No se puede abrir"),
                                                          ),
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Theme.of(context3)
                                                                .canvasColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft: const Radius
                                                              .circular(10),
                                                          topRight: const Radius
                                                              .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                      } else {
                                        showModalBottomSheet(
                                          context: context3,
                                          builder: (_) => SingleChildScrollView(
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height / 3,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                          icon:
                                                              Icon(Icons.close),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context3);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      allCon,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Theme.of(context3)
                                                                .shadowColor,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context3);
                                                        Navigator.of(context3)
                                                            .pushNamed(
                                                          '/DirIntoDirIntoDir',
                                                          arguments: <String,
                                                              String>{
                                                            'dirName': allCon,
                                                            'beforeName': widget
                                                                    .dirName +
                                                                widget
                                                                    .beforeName,
                                                          },
                                                        );
                                                      },
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons.upload_file,
                                                          color: Colors.blue,
                                                        ),
                                                        title: Text(
                                                          'Abrir Carpeta',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        try {
                                                          http.Response res =
                                                              await http.post(bloc
                                                                      .initialUrl +
                                                                  "dirRemove/${widget.dirName}/$allCon");
                                                          var decoded =
                                                              jsonDecode(
                                                                  res.body);
                                                          content =
                                                              Api.fromJson(
                                                                  decoded);
                                                          if (content.success) {
                                                            _scaffoldKey
                                                                .currentState
                                                                .showSnackBar(snackBar(
                                                                    "Carpeta eliminada",
                                                                    SnackBarBehavior
                                                                        .fixed));
                                                          } else {
                                                            _scaffoldKey
                                                                .currentState
                                                                .showSnackBar(snackBar(
                                                                    "Esta carpeta tiene contenido dentro",
                                                                    SnackBarBehavior
                                                                        .fixed));
                                                          }
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                        Navigator.pop(context3);
                                                      },
                                                      child: ListTile(
                                                        leading: Icon(
                                                          Icons
                                                              .create_new_folder_rounded,
                                                          color: Colors.green,
                                                        ),
                                                        title: Text(
                                                          'Eliminar Carpeta',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context3)
                                                      .canvasColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10),
                                                    topRight:
                                                        const Radius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Card(
                                      elevation: 3.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          imgFile(allCon),
                                          Flexible(
                                            fit: FlexFit.loose,
                                            child: Text(
                                              allCon,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          if (allCon.contains(".ini"))
                                            Text("No abrir"),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList());
                        }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => bNewFileOrDir(context, bloc.initialUrl,
                        widget.dirName, _scaffoldKey, _formKey, false));
              },
              child: Icon(Icons.add),
              tooltip: "Añadir",
            ),
          );
        },
      ),
    );
  }
}
