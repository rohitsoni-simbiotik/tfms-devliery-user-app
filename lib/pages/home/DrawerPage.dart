import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/constants/AssetConstants.dart';
import 'package:tfms_delivery_user_app/controller/AuthController.dart';
import 'package:tfms_delivery_user_app/pages/home/ChangePasswordPage.dart';
import 'package:tfms_delivery_user_app/utils/ViewUtils.dart';

class DrawerPage extends StatefulWidget {
  final int drawerIndex;

  const DrawerPage({Key? key, required this.drawerIndex}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final _authController = Get.find<AuthController>();

  final Map<String, String> _drawerListItems = {
    "Profile": AssetConstants.USER_ICON,
    "Change Password": AssetConstants.LOCK_ICON,
    "Logout": AssetConstants.LOGOUT_ICON
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          toolbarHeight: 0,
          backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        // width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Material(
              color: Colors.transparent,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _userProfileWidget(),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _drawerListItems.length,
                          itemBuilder: (context, index) {
                            return _menuItem(
                                title: _drawerListItems.keys.elementAt(index),
                                index: index,
                                icon: _drawerListItems.values.elementAt(index),
                                onTap: () {
                                  if (index == 9) //Logout Option
                                  {
                                  } else {
                                    Get.offAllNamed("/home");
                                  }
                                  changeDrawerMenuOption(
                                      _drawerListItems.keys.elementAt(index));
                                });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userProfileWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _authController.userResponseModel.profilePictureUrl?.isNotEmpty ??
                  false
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 44,
                  child: CachedNetworkImage(
                    imageUrl:
                        _authController.userResponseModel.profilePictureUrl ??
                            '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 44,
                  child: _authController.userResponseModel.profilePictureUrl ==
                          null
                      ? Image.asset(
                          AssetConstants.USER_PLACEHOLDER,
                          width: 120,
                          height: 120,
                        )
                      : null,
                ),
          const SizedBox(height: 10),
          Text('Welcome, ${_authController.userResponseModel.name ?? 'Anny'}',
              style: Get.textTheme.headline6!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
          Text(
              'Last Login, ${_authController.userResponseModel.lastLogin ?? '25/08/2022 : 03:00 PM'}',
              style: Get.textTheme.bodyText1!.copyWith(
                  color: ColorConstants.TEXT_GREY,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  changeDrawerMenuOption(String title) {
    switch (title) {
      case 'Profile':
        break;
      case 'Change Password':
        Get.to(() => const ChangePasswordPage(),
            transition: Transition.noTransition, duration: Duration.zero);
        break;
      case 'Logout':
        Get.dialog(ViewUtils.confirmExitDialogBox(logoutCallback: () {
          Get
            ..back()
            ..back();
          Get.find<AuthController>().logout();
        }));
    }
  }

  _menuItem(
      {required String title,
      required int index,
      required VoidCallback onTap,
      required String icon}) {
    return Container(
      color: widget.drawerIndex == index
          ? ColorConstants.DRAWER_SELECTED
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SvgPicture.asset(icon, width: 24),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(title,
                    style: Get.textTheme.subtitle1!.copyWith(
                        color: ColorConstants.LIGHT_BLACK,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
