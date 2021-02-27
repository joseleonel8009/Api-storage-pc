import 'dart:convert';
import 'package:app/Api/Api.dart';
import 'package:app/Provider/ApiResponseBLoC.dart';
import 'package:app/widgets/components/SnackBar.dart';
import 'package:app/widgets/components/imgFile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CarpetaScreen extends StatefulWidget {
  CarpetaScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApiResponseBLoC()..getData(null),
      builder: (_, __) => CarpetaScreen._(),
    );
  }

  @override
  _CarpetaScreenState createState() => _CarpetaScreenState();
}

class _CarpetaScreenState extends State<CarpetaScreen> {
  // Api api;
  Api content;
  var name;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // loadData();
      Provider.of<ApiResponseBLoC>(context, listen: false)..getData(null);
    });
    super.initState();

    // loadData();
  }

  // loadData() async {
  //   try {
  //     var response = await http.get(url);
  //     var decoded = jsonDecode(response.body);
  //     api = Api.fromJson(decoded);
  //     setState(() {});
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApiResponseBLoC>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Contenido"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF329d9c),
        leading: IconButton(
          tooltip: "Volver",
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Refrescar",
            onPressed: () => bloc.getData(null),
          )
        ],
      ),
      body: bloc.getData(null) == null
          ? Center(
              child: Text("No hay datos"),
            )
          : bloc.api == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  future: bloc.getData(null),
                  builder: (BuildContext context, _) {
                    return bloc.api.content.directories == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            children:
                                bloc.api.content.directories.map((allCon) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) => SingleChildScrollView(
                                        child: Container(
                                          color: Colors.white,
                                          height: size.height / 2,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
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
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      "/DirIntoDir",
                                                      arguments: <String,
                                                          String>{
                                                        'dirName': allCon,
                                                        'beforeName': bloc
                                                            .api.path
                                                            .replaceAll(
                                                                "\\", "--"),
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
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    try {
                                                      http.Response res =
                                                          await http.post(bloc
                                                                  .initialUrl +
                                                              "dirRemove/$allCon");
                                                      var decoded =
                                                          jsonDecode(res.body);
                                                      content =
                                                          Api.fromJson(decoded);
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
                                                      _scaffoldKey.currentState
                                                          .showSnackBar(snackBar(
                                                              "Ha ocurrido un error",
                                                              SnackBarBehavior
                                                                  .fixed));
                                                    }
                                                    Navigator.pop(context);
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
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).canvasColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(10),
                                                topRight:
                                                    const Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 3.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        imgFile(allCon),
                                        Text(
                                          allCon,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
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
        child: Icon(Icons.add),
        onPressed: () async {
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
                        key: _formKey,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
                              labelText: "Nombre para la capeta",
                              labelStyle: TextStyle(
                                  color: Theme.of(context).accentColor),
                              contentPadding: EdgeInsets.all(12),
                              hintText: "Nombre para la carpeta",
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.7)),
                              prefixIcon: Icon(Icons.folder,
                                  color: Theme.of(context).accentColor),
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
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              await http
                                  .post(bloc.initialUrl + "dirCreate/$name");
                              _scaffoldKey.currentState.showSnackBar(snackBar(
                                  "Carpeta creada", SnackBarBehavior.fixed));
                            } catch (e) {
                              print(e);
                            }
                            Navigator.pop(context);
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
        },
      ),
    );
  }
}
