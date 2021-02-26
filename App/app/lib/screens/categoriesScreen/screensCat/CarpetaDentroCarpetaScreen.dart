import 'dart:convert';
import 'package:app/widgets/components/ModalBottomSheet.dart';
import 'package:app/widgets/components/bNewFileOrDir.dart';
import 'package:app/widgets/components/imgFile.dart';
import 'package:http/http.dart' as http;
import 'package:app/Api/Api.dart';
import 'package:flutter/material.dart';

class CarpetaDentroCarpetaScreen extends StatefulWidget {
  final String dirName;
  final String beforeName;
  final String url;

  const CarpetaDentroCarpetaScreen(
      {Key key, this.dirName, this.beforeName, this.url});

  @override
  _CarpetaDentroCarpetaScreenState createState() =>
      _CarpetaDentroCarpetaScreenState();
}

class _CarpetaDentroCarpetaScreenState
    extends State<CarpetaDentroCarpetaScreen> {
  Api api;
  var name;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
    super.initState();
  }

  loadData() async {
    try {
      var response =
          await http.get(widget.url + widget.beforeName + widget.dirName);
      var decoded = jsonDecode(response.body);
      api = Api.fromJson(decoded);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Refrescar",
            onPressed: () {
              loadData();
            },
          )
        ],
      ),
      body: api == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : api.content == null
              ? Center(
                  child: Text("No hay datos"),
                )
              : FutureBuilder(
                  future: loadData(),
                  builder: (BuildContext context, snapshot) {
                    return GridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        children: api.content.files.map((files) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                if (files.endsWith(".mp4") ||
                                    files.endsWith(".doc") ||
                                    files.endsWith(".png") ||
                                    files.endsWith(".jpg") ||
                                    files.endsWith(".pdf") ||
                                    files.endsWith(".doc") ||
                                    files.endsWith(".docx")) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) => bottomSheet(
                                          context,
                                          files,
                                          widget.url,
                                          files,
                                          widget.beforeName + widget.dirName,
                                          _scaffoldKey));
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
                                    imgFile(files),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        files,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    if (files.contains(".ini"))
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
              builder: (_) => bNewFileOrDir(
                  context,
                  widget.url,
                  widget.beforeName + widget.dirName,
                  _scaffoldKey,
                  _formKey,
                  true));
        },
        child: Icon(Icons.add),
        tooltip: "Añadir",
      ),
    );
  }
}
