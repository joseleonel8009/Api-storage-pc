import 'package:flutter/material.dart';

class CatModel {
  final Color color;
  final String title, subtitle, imgIcon, routeName;

  CatModel({
    this.routeName,
    this.imgIcon,
    this.color,
    this.title,
    this.subtitle,
  });
}

List<CatModel> category = [
  CatModel(
    routeName: "/Dirs",
    imgIcon: "assets/images/folder.png",
    title: "Carpetas",
    subtitle: "carpetas",
    color: Color(0xFF329d9c),
  ),
  CatModel(
    routeName: "/Files",
    imgIcon: "assets/images/file.png",
    title: "Archivos",
    subtitle: "archivos",
    color: Color(0xFF7be495),
  ),
];
