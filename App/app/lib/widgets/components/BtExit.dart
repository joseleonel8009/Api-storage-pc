import 'package:flutter/material.dart';

class BtExit extends StatelessWidget {
  final Function onTap;
  final Icon icon;
  final String tooltip;
  final Color color;

  const BtExit({
    Key key,
    @required this.onTap,
    @required this.icon,
    @required this.tooltip,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      color: color,
      onPressed: onTap,
    );
  }
}
