import 'dart:async';
// import 'dart:convert';
// import 'package:app/Api/Api.dart';
import 'package:app/Provider/ApiResponseBLoC.dart';
// import 'package:app/Provider/ApiResponseBLoC.dart';
import 'package:app/widgets/components/BtExit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
import 'package:app/model/catModel.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ApiResponseBLoC()..getData(null),
      builder: (_, __) => MainScreen._(),
    );
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Api api;
  bool isReload = false;
  // var url = "http://192.168.1.3:3000/";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // loadData();
      Provider.of<ApiResponseBLoC>(context, listen: false);
    });
    super.initState();
  }

  // loadData() async {

  //   // try {
  //   //   var response = await http.get(url);
  //   //   var decoded = jsonDecode(response.body);
  //   //   api = Api.fromJson(decoded);
  //   //   setState(() {});
  //   // } catch (e) {
  //   //   print(e);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _popScope,
      child: Scaffold(
        backgroundColor: Color(0xFFf9f7f7),
        body: SingleChildScrollView(
          child: Column(
            children: [
              body(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _popScope() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("¿Seguro que quieres salir?"),
        actions: [
          FlatButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text("Si"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No"),
          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        topBar(),
        cat(context),
      ],
    );
  }

  Widget topBar() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Color(0xFF329d9c),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Hola!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              BtExit(
                onTap: () {
                  SystemNavigator.pop();
                },
                icon: Icon(
                  Icons.exit_to_app_rounded,
                  size: 40,
                ),
                tooltip: "Salir",
                color: Colors.white,
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cat(BuildContext context) {
    final bloc = Provider.of<ApiResponseBLoC>(context);
    return SizedBox(
      height: 400,
      child: Center(
        child: bloc.api == null && bloc.getData(null) != null
            ? Center(
                child: !isReload
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sin servició",
                            style: TextStyle(
                              fontSize: 36,
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                isReload = !isReload;
                              });
                              Timer(Duration(seconds: 20), () {
                                setState(() {
                                  isReload = !isReload;
                                });
                              });
                            },
                            child: Text(
                              "Reintentar",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Theme.of(context).accentColor,
                          ),
                        ],
                      )
                    : FutureBuilder(
                        future: bloc.getData(null),
                        builder: (BuildContext context, index) {
                          return CircularProgressIndicator();
                        },
                      ),
              )
            : bloc.api.content == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder(
                    // future: loadData(),
                    future: bloc.getData(null),
                    builder: (context, _) {
                      var size = MediaQuery.of(context).size;
                      return bloc.api.content.all == null
                          ? Center(
                              child: Text("No hay datos"),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(left: size.height / 10),
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: category.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 30, right: 20),
                                  child: InkWell(
                                    onTap: () {
                                      if (category[index].routeName ==
                                          "/Dirs") {
                                        Navigator.pushNamed(context, "/Dirs");
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (_) => CarpetaScreen()));
                                      } else {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text("La ruta no existe"),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }
                                    },
                                    child: Container(
                                      // height: 250,
                                      width: 260,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: category[index].color,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Image.asset(
                                                category[index].imgIcon),
                                          ),
                                          Text(
                                            category[index].title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            bloc.api == null
                                                ? 0.toString()
                                                : bloc.api.content.directories
                                                        .length
                                                        .toString() +
                                                    " " +
                                                    category[index].subtitle1,
                                            style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
      ),
    );
  }
}
