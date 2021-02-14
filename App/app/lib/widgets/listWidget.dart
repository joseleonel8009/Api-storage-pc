import 'package:flutter/material.dart';
import 'package:app/widgets/components/List.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          List(
            icon1: "assets/images/file.png",
            icon2: "assets/images/file.png",
            title1: "MyFile",
            file1: "1200",
            title2: "APP",
            file2: "200",
          ),
          List(
            icon1: "assets/images/video.png",
            icon2: "assets/images/video.png",
            title1: "Videos",
            file1: "1200",
            title2: "Video",
            file2: "200",
          ),
          List(
            icon1: "assets/images/picture.png",
            icon2: "assets/images/picture.png",
            title1: "Imagen",
            file1: "1200",
            title2: "Music",
            file2: "200",
          ),
          List(
            icon1: "assets/images/picture.png",
            icon2: "assets/images/picture.png",
            title1: "Picture",
            file1: "1200",
            title2: "Music",
            file2: "200",
          ),
        ],
      ),
    );
  }
}
