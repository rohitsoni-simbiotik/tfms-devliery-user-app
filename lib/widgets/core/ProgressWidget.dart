import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';

class ProgressWidget extends StatelessWidget {
  final String progressText;

  const ProgressWidget(this.progressText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              PlatformCircularProgressIndicator(),
              const SizedBox(width: 20),
              Text(
                progressText,
                style: Get.textTheme.subtitle1!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
