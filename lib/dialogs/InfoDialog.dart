import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';

class InfoDialog extends StatefulWidget {
  final String? msg;
  final String? btnTitle;
  final VoidCallback? callback;

  const InfoDialog({
    Key? key,
    this.msg,
    this.btnTitle = 'Ok',
    this.callback,
  }) : super(key: key);

  @override
  State<InfoDialog> createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: dialogContent(),
        contentPadding: EdgeInsets.zero);
  }

  Widget dialogContent() {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 12, right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorConstants.BACKGROUND,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.msg ?? '',
                    style: Get.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                RoundedButton(
                    onPressed: widget.callback ?? () => Get.back(),
                    isExpanded: true,
                    enabledColor: ColorConstants.GREEN_COLOR,
                    text: widget.btnTitle ?? 'Ok'),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
