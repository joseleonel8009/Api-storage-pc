import 'package:flutter/material.dart';

class FileVideoScreen extends StatefulWidget {
  final String url, path, name;

  const FileVideoScreen({this.url, this.path, this.name});

  @override
  _FileVideoScreenState createState() => _FileVideoScreenState();
}

class _FileVideoScreenState extends State<FileVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF329d9c),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Center(
        child: Text(widget.name),
      ),
    );
  }
}
