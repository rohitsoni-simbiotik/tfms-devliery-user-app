import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/AppConstants.dart';

class RoundedOutlinedButton extends StatelessWidget {
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
  const RoundedOutlinedButton(
      {Key? key,
      this.onPressed,
      this.child,
      this.text,
      this.enabledColor,
      this.disabledColor,
      this.textColor,
      this.splashColor,
      this.radius = 52,
      this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      this.isExpanded = false,
      this.isEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? btnChild;
    final style = ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(
              color: isEnabled
                  ? (enabledColor ?? ColorConstants.PRIMARY)
                  : (disabledColor ?? ColorConstants.DISABLED_BUTTON),
            ),
          ),
        ),
        overlayColor: MaterialStateProperty.all(
            (splashColor ?? Colors.white).withOpacity(0.2)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(padding));
    if (text != null && child == null) {
      btnChild = Text(text!,
          textAlign: TextAlign.center,
          style: Get.textTheme.button!.copyWith(
              fontSize: 16,
              color: isEnabled
                  ? (textColor ?? enabledColor ?? ColorConstants.PRIMARY)
                  : (disabledColor ?? ColorConstants.DISABLED_BUTTON)));
    } else {
      btnChild = child;
    }
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btnChild ?? Container(),
        ],
      ),
      style: style,
    );
  }
}
