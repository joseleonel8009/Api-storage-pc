import 'package:flutter/material.dart';

class CatModel {
  final Color color;
  final String title, subtitle1, subtitle2, imgIcon, routeName;

  CatModel(
      {this.routeName,
      this.imgIcon,
      this.color,
      this.title,
      this.subtitle1,
      this.subtitle2});
}

List<CatModel> category = [
  CatModel(
    routeName: "/Dirs",
    imgIcon: "assets/images/explorador-de-archivos.png",
    title: "Explorador de Archivos",
    subtitle1: "Carpetas",
    subtitle2: "Archivos",
    color: Color(0xFF329d9c),
  ),
];
