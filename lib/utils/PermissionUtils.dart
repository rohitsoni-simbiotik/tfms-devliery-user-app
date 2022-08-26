import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/core/RoundedButton.dart';

class PermissionUtils {
  static Future<bool> checkPermission(Permission permission) async {
    final status = await permission.request();
    if (status == PermissionStatus.permanentlyDenied) {
      Get.defaultDialog(
        title: "Permission Required!",
        content: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "This application need to use some permissions, you can grant them in the application settings.",
          ),
        ),
        cancel: TextButton(
            onPressed: () => Get.back(),
            child: Text("Close",
                style: Get.textTheme.button!.copyWith(color: Colors.grey))),
        confirm: RoundedButton(
            onPressed: () async {
              Get.back();
              await openAppSettings();
            },
            child: const Text("Open App Settings")),
      );
    }
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
