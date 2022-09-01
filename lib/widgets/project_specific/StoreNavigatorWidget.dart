import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/utils/LocationUtils.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';

class StoreNavigatorWidget extends StatelessWidget {
  final double lat;
  final double lng;

  const StoreNavigatorWidget({
    Key? key,
    this.lat = 0.0,
    this.lng = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      margin: EdgeInsets.zero,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                    angle: math.pi / 4,
                    child: const Icon(Icons.navigation_rounded,
                        color: ColorConstants.PRIMARY, size: 48)),
                const SizedBox(height: 18),
                Text('Choose Application',
                    style: Get.textTheme.subtitle1!.copyWith(
                        color: ColorConstants.PRIMARY,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 18),
                const Divider(),
                Visibility(
                  visible: GetPlatform.isIOS,
                  child: Column(
                    children: [
                      RoundedButton(
                          enabledColor: Colors.white,
                          splashColor: ColorConstants.PRIMARY,
                          isExpanded: true,
                          onPressed: () {
                            LocationUtils.openAppleMap(lat, lng);
                          },
                          child: Text('Apple Maps',
                              style: Get.textTheme.subtitle1)),
                      const Divider(),
                    ],
                  ),
                ),
                Visibility(
                  visible: GetPlatform.isAndroid,
                  child: Column(
                    children: [
                      RoundedButton(
                          enabledColor: Colors.white,
                          splashColor: ColorConstants.PRIMARY,
                          isExpanded: true,
                          onPressed: () {
                            LocationUtils.openGoogleMap(lat, lng);
                          },
                          child: Text('Google Maps',
                              style: Get.textTheme.subtitle1)),
                      const Divider(),
                    ],
                  ),
                ),
                RoundedButton(
                    enabledColor: Colors.white,
                    splashColor: ColorConstants.PRIMARY,
                    isExpanded: true,
                    onPressed: () {
                      LocationUtils.openWazeMap(lat, lng);
                    },
                    child: Text('Waze', style: Get.textTheme.subtitle1)),
                const Divider(),
                const SizedBox(height: 12),
                RoundedButton(
                  text: 'Cancel',
                  isExpanded: true,
                  onPressed: () => Get.back(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
