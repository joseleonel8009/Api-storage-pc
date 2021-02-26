// import 'dart:convert';
// import 'package:app/Api/Api.dart';
import 'package:app/Provider/ApiResponseBLoC.dart';
import 'package:app/widgets/components/SnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArchivoScreen extends StatefulWidget {
  ArchivoScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApiResponseBLoC(),
      builder: (_, __) => ArchivoScreen._(),
    );
  }

  @override
  _ArchivoScreenState createState() => _ArchivoScreenState();
}

class _ArchivoScreenState extends State<ArchivoScreen> {
  // String url = "http://192.168.1.3:3000/";
  // Api api;
  var name;
  // final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ApiResponseBLoC>(context, listen: false);
    });
    super.initState();
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
        title: Text("Archivos"),
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
            onPressed: () => bloc.getData,
          )
        ],
      ),
      body: bloc.api == null
          ? Center(
              child: Text("No hay datos"),
            )
          : bloc.api.content == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  // future: loadData(),
                  future: bloc.getData(null),
                  builder: (context, snapshot) {
                    return GridView.count(
                        crossAxisCount: 2,
                        children: bloc.api.content.files.map((fileName) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                if (fileName.endsWith(".mp4") ||
                                    fileName.endsWith(".doc") ||
                                    fileName.endsWith(".png") ||
                                    fileName.endsWith(".jpg") ||
                                    fileName.endsWith(".pdf") ||
                                    fileName.endsWith(".doc") ||
                                    fileName.endsWith(".docx")) {
                                  showModalBottomSheet(
                                    context: context,
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
                                                    arguments: <String, String>{
                                                      'dirName': fileName,
                                                      'beforeName': bloc
                                                          .api.path
                                                          .replaceAll(
                                                              "\\", "--"),
                                                      'url': bloc.initialUrl,
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
                                                    await http.post(bloc
                                                            .initialUrl +
                                                        "dirRemove/$fileName");
                                                    _scaffoldKey.currentState
                                                        .showSnackBar(snackBar(
                                                            "Carpeta eliminada",
                                                            SnackBarBehavior
                                                                .fixed));
                                                  } catch (e) {
                                                    print(e);
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
                                } else {
                                  showModalBottomSheet(
                                    context: context,
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
                                                    icon: Icon(Icons.close),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Center(
                                                child:
                                                    Text("No se puede abrir"),
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
                                }
                              },
                              child: Card(
                                elevation: 3.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            fileName.contains(".ini")
                                                ? "assets/images/close.png"
                                                : "assets/images/folder.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      fileName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    if (fileName.contains(".ini"))
                                      Text("No abrir"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList());
                  },
                ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Añadir",
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
