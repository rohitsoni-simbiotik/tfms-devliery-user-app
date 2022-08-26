import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
