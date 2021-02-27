import 'package:app/screens/ErrScreen.dart';
import 'package:app/screens/MainScreen.dart';
import 'package:app/screens/SplashScreen.dart';
import 'package:app/screens/categoriesScreen/CarpetaScreen.dart';
import 'package:app/screens/categoriesScreen/screensCat/CarpetaDentroCarpetaScreen.dart';
import 'package:app/screens/categoriesScreen/screensCat/CarpetaSubScreen.dart';
import 'package:app/screens/viewFileScreens/FileDocScreen.dart';
import 'package:app/screens/viewFileScreens/FileImageScreen.dart';
import 'package:app/screens/viewFileScreens/FilePdfScreen.dart';
import 'package:app/screens/viewFileScreens/FileVideoScreen.dart';
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
      case '/DirIntoDir':
        return MaterialPageRoute(
            builder: (context) => CarpetaSubScreen(
                  dirName: data['dirName'],
                  beforeName: data['beforeName'],
                )
            // dirName: data['dirName'],
            // beforeName: data['beforeName'],
            // url: data['url'],
            );
      case '/DirIntoDirIntoDir':
        return MaterialPageRoute(
            builder: (context) => CarpetaDentroCarpetaScreen(
                  dirName: data['dirName'],
                  beforeName: data['beforeName'],
                ));
      case '/fileImage':
        return MaterialPageRoute(
          builder: (context) => FileImageScreen(
            url: data['url'],
            fileName: data['fileName'],
            path: data['path'],
          ),
        );
      case '/fileVideo':
        return MaterialPageRoute(
          builder: (context) => FileVideoScreen(
            url: data['url'],
            name: data['name'],
            path: data['path'],
          ),
        );
      case '/fileDoc':
        return MaterialPageRoute(builder: (context) => FileDocScreen());
      case '/filePdf':
        return MaterialPageRoute(
          builder: (context) => FilePdfScreen(
            url: data['url'],
            path: data['path'],
            name: data['name'],
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => ErrScreen());
    }
  }
}
