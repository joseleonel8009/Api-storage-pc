import 'package:app/Provider/SplashBLoC.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen._();

  static Widget init(BuildContext context) {
    // ESTO ES COMO UN CONTROLADOR
    return ChangeNotifierProvider(
        create: (_) => SplashBLoC(),
        builder: (context, snapshot) {
          return SplashScreen._();
        });
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPermission();
    });
    super.initState();
  }

  getPermission() async {
    Duration duration = Duration(seconds: 3);
    final bloc = context.read<SplashBLoC>();
    final res = await bloc.getPermission();
    if (res) {
      Future.delayed(duration, () {
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (_) => MainScreen.init(context)));
        Navigator.pushReplacementNamed(context, "/Main");
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Debe dar permiso a la app"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                getPermission();
              },
              child: Text("Reintentar"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF138086),
              Color(0xFF7be495),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(100),
              child: Image.asset(
                "assets/images/iconSplash.png",
              ),
            ),
            SizedBox(
              height: 150,
            ),
            CircularProgressIndicator(
              strokeWidth: 5,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).shadowColor),
            ),
          ],
        ),
      ),
    );
  }
}
