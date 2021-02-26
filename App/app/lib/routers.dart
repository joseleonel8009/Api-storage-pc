import 'package:app/screens/ErrScreen.dart';
import 'package:app/screens/MainScreen.dart';
import 'package:app/screens/SplashScreen.dart';
import 'package:app/screens/categoriesScreen/ArchivoScreen.dart';
import 'package:app/screens/categoriesScreen/CarpetaScreen.dart';
import 'package:app/screens/categoriesScreen/screensCat/CarpetaDentroCarpetaScreen.dart';
import 'package:app/screens/categoriesScreen/screensCat/CarpetaSubScreen.dart';
import 'package:flutter/material.dart';

class OnRouter {
  static Route<dynamic> routers(RouteSettings settings) {
    final data = settings.arguments as Map<String, dynamic>;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(
            builder: (context) => SplashScreen.init(context));
      case '/Main':
        return MaterialPageRoute(
            builder: (context) => MainScreen.init(context));
      case '/Dirs':
        return MaterialPageRoute(
            builder: (context) => CarpetaScreen.init(context));
      case '/Files':
        return MaterialPageRoute(
            builder: (context) => ArchivoScreen.init(context));
      case '/DirIntoDir':
        return MaterialPageRoute(
            builder: (context) => CarpetaSubScreen(
                  dirName: data['dirName'],
                  beforeName: data['beforeName'],
                  url: data['url'],
                ));
      case '/DirIntoDirIntoDir':
        return MaterialPageRoute(
            builder: (context) => CarpetaDentroCarpetaScreen(
                  dirName: data['dirName'],
                  beforeName: data['beforeName'],
                  url: data['url'],
                ));
      case '/file':
        return MaterialPageRoute(
            builder: (context) => ArchivoScreen.init(context));
      default:
        return MaterialPageRoute(builder: (_) => ErrScreen());
    }
  }
}
