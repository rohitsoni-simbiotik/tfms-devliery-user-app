import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/constants/AssetConstants.dart';
import 'package:tfms_delivery_user_app/pages/home/NotificationListPage.dart';
import 'package:tfms_delivery_user_app/widgets/CustomSwitch.dart';

class DrawerAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final IconData? leadingIcon;
  final VoidCallback? leadingCallback;
  final Function(bool)? toggleSwitchCallback;
  final bool? switchValue;

  const DrawerAppBarWidget(
      {Key? key,
      this.title,
      this.leadingIcon,
      this.leadingCallback,
      this.toggleSwitchCallback,
      this.switchValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(leadingIcon ?? Icons.menu, color: Colors.black),
          onPressed: leadingCallback,
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 40, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomSwitch(
                value: switchValue ?? false,
                switchHeight: 32,
                switchWidth: 54,
                thumbSize: 26,
                activeColor: ColorConstants.PRIMARY,
                onChanged: (value) {
                  toggleSwitchCallback?.call(value);
                },
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const NotificationListPage());
                },
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: ColorConstants.SHADOW_COLOR.withOpacity(0.25),
                          blurRadius: 6,
                          spreadRadius: -2,
                          offset: const Offset(0, 1),
                        )
                      ]),
                      child: SvgPicture.asset(
                        AssetConstants.NOTIFICATION_ICON,
                        height: 120,
                        width: 120,
                      ),
                    )),
              )
            ],
          ),
        ),
        title: Text(
          title ?? '',
          style: Get.textTheme.headline6?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
