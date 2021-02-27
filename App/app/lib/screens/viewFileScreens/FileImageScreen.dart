import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class FileImageScreen extends StatefulWidget {
  final String url, path, fileName;

  FileImageScreen({this.url, this.path, this.fileName});

  @override
  _FileImageScreenState createState() => _FileImageScreenState();
}

class _FileImageScreenState extends State<FileImageScreen> {
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
        title: Text(widget.fileName),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.fileName,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FullScreenWidget(
            child: Image.network(
              widget.url + "file/" + widget.path + "/" + widget.fileName,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
