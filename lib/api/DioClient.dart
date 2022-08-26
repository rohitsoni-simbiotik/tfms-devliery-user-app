import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/utils/SharedPrefs.dart';
import '../constants/APIConstants.dart';
export '../utils/Extensions.dart' show DioResponseExtension;

class DioClient {
  static Dio? _dio;

  static Dio get client {
    return Get.find<Dio>();
  }

  static init() {
    if (_dio == null) {
      _dio = Dio(BaseOptions(
        baseUrl: APIConstants.BASE_URL,
        validateStatus: (status) {
          return status! <= 500;
        },
        headers: {
          'Accept': 'application/json',
        },
      ));

      _dio!.interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions req, RequestInterceptorHandler handler) async {
        // String? token = Get.find<AuthController>().member.token;
        // token ??= SharedPrefs.readStringValue(PrefConstants.ACCESS_TOKEN);
        // debugPrint(token);
        // if (token.isNotEmpty) {
        //   req.headers['Authorization'] = 'Bearer $token';
        // }
        return handler.next(req);
      }, onResponse:
          (Response<dynamic> resp, ResponseInterceptorHandler handler) async {
        // if (resp.statusCode == 401) {
        //   Get.find<AuthController>().logout();
        // }
        return handler.next(resp);
      }, onError: (DioError error, ErrorInterceptorHandler handler) async {
        return handler.next(error);
      }));
    }
    Get.put(_dio!, permanent: true);
  }
}

Future<void> showError(error) async {
  String title = "Error";
  String message = error.toString();
  if (error is DioError) {
    title = "API Error";
    message = error.message;
  } else if (error is PlatformException) {
    title = "Error";
    message = error.message ?? error.toString();
  } else if (error is Map && error.containsKey('message')) {
    if (error['message'] is List) {
      title = "API Error";
      message = (error['message'] as List).join('\n');
    } else {
      title = error['message'];
      message = "API Error ${error['statusCode'] ?? ''}";
    }
  }
  if (Get.context != null) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        backgroundColor: Colors.black87,
        duration: const Duration(seconds: 5),
        colorText: Colors.white);
  }
}

Future<void> showMessage(String title, String message) async {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      backgroundColor: Colors.black87,
      duration: const Duration(seconds: 3),
      colorText: Colors.white);
}
