import 'package:flutter/material.dart';

Widget snackBar(String txt, SnackBarBehavior behavior) {
  return SnackBar(
    content: Text(txt),
    behavior: behavior,
  );
}
