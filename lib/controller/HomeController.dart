import 'dart:async';

import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/api/DioClient.dart';

class HomeController extends GetxController {
  final RxBool _showProgress = false.obs;
  bool get showProgress => _showProgress.value;
  set showProgress(val) => _showProgress.value = val;

  final RxBool _isSwitchOn = false.obs;
  bool get isSwitchOn => _isSwitchOn.value;
  set setIsSwitchOn(val) => _isSwitchOn.value = val;

  Future<void> init() async {
    try {} catch (e) {
      showError(e);
    }
  }
}
