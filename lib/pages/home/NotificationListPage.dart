import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/controller/HomeController.dart';
import 'package:tfms_delivery_user_app/pages/home/DrawerPage.dart';
import 'package:tfms_delivery_user_app/widgets/DrawerAppBarWidget.dart';
import 'package:tfms_delivery_user_app/widgets/core/ProgressContainerView.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({Key? key}) : super(key: key);

  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  final _authController = Get.find<AuthController>();
  final _homeController = Get.find<HomeController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authController.getNotificationList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ProgressContainerView(
        isProgressRunning:
            _authController.showProgress || _homeController.showProgress,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: DrawerAppBarWidget(
              title: 'Notifications',
              leadingCallback: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              toggleSwitchCallback: (value) {
                _homeController.setIsSwitchOn = value;
              },
              switchValue: _homeController.isSwitchOn),
          drawer: const Drawer(child: DrawerPage(drawerIndex: 0)),
          body: _body(),
        ),
      ),
    );
  }

  _body() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: _authController.notificationList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 1),
                )
              ]),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                _authController.notificationList[index].title ?? '',
                style: Get.textTheme.subtitle1
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(_authController.notificationList[index].dateTime ?? '',
                  style: Get.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.w400)),
              const SizedBox(height: 20),
              Text(_authController.notificationList[index].desc ?? '',
                  style: Get.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.w400)),
            ]),
          ),
        );
      },
    );
  }
}
