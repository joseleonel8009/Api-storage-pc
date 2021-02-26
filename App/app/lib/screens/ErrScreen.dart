import 'package:flutter/material.dart';

class ErrScreen extends StatefulWidget {
  @override
  _ErrScreenState createState() => _ErrScreenState();
}

class _ErrScreenState extends State<ErrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "404 Not Found",
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/Main");
            },
            child: Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Ir a la principal"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
