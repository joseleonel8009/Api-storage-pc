import 'package:flutter/material.dart';

Widget imgFile(con) {
  return Container(
    height: 90,
    width: 90,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(con.endsWith(".mp4")
            ? "assets/images/video.png"
            : con.endsWith(".png") || con.endsWith(".jpg")
                ? "assets/images/picture.png"
                : con.contains(".ini")
                    ? "assets/images/close.png"
                    : con.endsWith(".pdf")
                        ? "assets/images/pdf.png"
                        : con.endsWith(".doc") || con.endsWith(".docx")
                            ? "assets/images/word.png"
                            : "assets/images/folder.png"),
      ),
    ),
  );
}
