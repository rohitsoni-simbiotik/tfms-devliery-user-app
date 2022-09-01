import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationUtils {
  late Position currentLocation;
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      Get.defaultDialog(
        title: "Permission Required!",
        content: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "This application need to use location permissions, you can grant it from application settings.",
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
            text: 'Open App Settings'),
      );
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Get.defaultDialog(
          title: "Permission Required!",
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "This application need to use location permissions, you can grant it from application settings.",
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
              text: 'Open App Settings'),
        );
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return currentLocation;
  }

  static openGoogleMap(double lat, double lng) {
    launchUrl(
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng'));
  }

  static openAppleMap(double lat, double lng) {
    launchUrl(Uri.parse('https://maps.apple.com/?ll=$lat,$lng'));
  }

  static openWazeMap(double lat, double lng) {
    launchUrl(Uri.parse('https://www.waze.com/ul?ll=$lat,$lng'));
  }
}
