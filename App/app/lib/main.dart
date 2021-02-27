import 'package:flutter/material.dart';
import 'package:app/routers.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Cloud',
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
