import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/api/DioClient.dart';
import 'package:tfms_delivery_user_app/models/NotificationModel.dart';
import 'package:tfms_delivery_user_app/models/UserResponseModel.dart';
import 'package:tfms_delivery_user_app/pages/common/LoginPage.dart';
import 'package:tfms_delivery_user_app/pages/common/OTPPage.dart';
import 'package:tfms_delivery_user_app/pages/common/ResetPasswordPage.dart';
import 'package:tfms_delivery_user_app/pages/home/HomePage.dart';

class AuthController extends GetxController {
  final RxBool _showProgress = false.obs;
  bool get showProgress => _showProgress.value;
  set showProgress(val) => _showProgress.value = val;

  final Rx<UserLoginResponseModel> _userResponseModel =
      UserLoginResponseModel().obs;
  UserLoginResponseModel get userResponseModel => _userResponseModel.value;
  set setUser(usr) => _userResponseModel.value = usr;

  final RxList<NotificationDataModel> _notificationList =
      <NotificationDataModel>[].obs;
  List<NotificationDataModel> get notificationList => _notificationList;

  Future<void> init() async {
    try {} catch (e) {
      showError(e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _showProgress.value = true;
      Get.to(() => const HomePage());
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      _showProgress.value = true;
      Get.to(() => const OTPPage());
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> reSendOTP(
      {ValueChanged<int>? onResend, VoidCallback? onFinally}) async {
    try {
      _showProgress.value = true;
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
      onFinally?.call();
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      _showProgress.value = true;
      Get.to(() => const ResetPasswordPage());
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> resetPassword(String? password) async {
    try {
      _showProgress.value = true;
      Get.offAll(() => const LoginPage());
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> changePassword(String? password) async {
    try {
      _showProgress.value = true;
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> logout() async {
    try {
      _showProgress.value = true;
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> getNotificationList() async {
    try {
      _showProgress.value = true;
      _notificationList.value = dummyNotificationList;
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }
}
