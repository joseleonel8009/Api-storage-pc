import 'package:app/widgets/bodyWidget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black[],
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   elevation: 0.0,
      //   leading: Icon(
      //     Icons.hdr_weak,
      //     color: Colors.white,
      //   ),
      // ),
      body: BodyWidget(),
    );
  }
}
