import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/controller/HomeController.dart';
import 'package:tfms_delivery_user_app/pages/home/DrawerPage.dart';
import 'package:tfms_delivery_user_app/widgets/DrawerAppBarWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        appBar: DrawerAppBarWidget(
            title: 'Delivery Dashboard',
            leadingCallback: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            toggleSwitchCallback: (value) {
              _homeController.setIsSwitchOn = value;
            },
            switchValue: _homeController.isSwitchOn),
        drawer: const Drawer(child: DrawerPage(drawerIndex: 0)),
        body: WillPopScope(
          onWillPop: () async {
            if (_scaffoldKey.currentState!.isDrawerOpen) {
              Get.back();
              return false;
            } else {
              return true;
            }
          },
          child: Container(),
        ),
      ),
    );
  }
}
