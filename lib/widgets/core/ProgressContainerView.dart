import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ProgressWidget.dart';

class ProgressContainerView extends StatelessWidget {
  final Widget? child;
  final Widget? progressWidget;
  final bool? isProgressRunning;
  final String progressText;
  final double progressWidgetOpacity;

  const ProgressContainerView(
      {@required this.child,
      @required this.isProgressRunning,
      this.progressText = "Please Wait",
      this.progressWidgetOpacity = 0.6,
      this.progressWidget,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child ?? Container(),
        Positioned.fill(
          child: Visibility(
              visible: isProgressRunning ?? false,
              child: Container(
                  color: Colors.grey.withOpacity(progressWidgetOpacity),
                  child: progressWidget ?? ProgressWidget(progressText.tr))),
        ),
      ],
    );
  }
}
