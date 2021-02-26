import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashBLoC extends ChangeNotifier {
  Future<bool> getPermission() async {
    final res =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (res.values.contains(PermissionStatus.granted)) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }
}
