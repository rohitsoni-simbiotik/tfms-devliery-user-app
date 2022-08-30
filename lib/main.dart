import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tfms_delivery_user_app/api/DioClient.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/controller/HomeController.dart';
import 'package:tfms_delivery_user_app/pages/common/LoginPage.dart';
import 'package:tfms_delivery_user_app/pages/home/HomePage.dart';

void main() async {
  await GetStorage.init();
  DioClient.init();
  Get.put(AuthController());
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TFMS Delivery User App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Colors.white,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.grey[400]!)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.grey[400]!)),
            disabledBorder: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
            isDense: false),
        appBarTheme: Get.theme.appBarTheme.copyWith(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            titleSpacing: 0,
            backgroundColor: ColorConstants.BACKGROUND,
            elevation: 0),
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const LoginPage()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}
