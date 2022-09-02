import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/AppConstants.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? textColor;
  final Color? splashColor;
  final EdgeInsets padding;
  final double radius;
  final bool isExpanded;
  final bool isEnabled;
  final double? height;
  const RoundedButton(
      {Key? key,
      this.onPressed,
      this.child,
      this.text,
      this.enabledColor,
      this.disabledColor,
      this.textColor,
      this.splashColor,
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      this.radius = 6,
      this.isExpanded = false,
      this.isEnabled = true,
      this.height = 46})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? btnChild;
    final style = ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        overlayColor: MaterialStateProperty.all(
            (splashColor ?? Colors.white).withOpacity(0.2)),
        backgroundColor: MaterialStateProperty.all(isEnabled
            ? (enabledColor ?? ColorConstants.PRIMARY)
            : (disabledColor ?? ColorConstants.DISABLED_BUTTON)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(padding));
    if (text != null && child == null) {
      btnChild = Text(text!,
          style: Get.textTheme.button!.copyWith(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16));
    } else {
      btnChild = child;
    }
    return SizedBox(
      height: height,
      child: ElevatedButton(
        key: key,
        onPressed: isEnabled
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
                onPressed?.call();
              }
            : null,
        style: style,
        child: Row(
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnChild ?? Container(),
          ],
        ),
      ),
    );
  }
}
