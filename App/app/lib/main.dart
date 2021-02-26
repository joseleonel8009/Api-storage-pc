import 'package:flutter/material.dart';
import 'package:app/routers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Administrador de Archivos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Color(0xFF329d9c),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: SplashScreen.init(context),
      initialRoute: "/Splash",
      onGenerateRoute: OnRouter.routers,
    );
  }
}
