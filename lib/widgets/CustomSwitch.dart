import 'package:flutter/material.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final double? switchHeight;
  final double? switchWidth;
  final double? thumbSize;

  CustomSwitch(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.activeColor,
      this.switchHeight,
      this.switchWidth,
      this.thumbSize})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged?.call(true)
                : widget.onChanged?.call(false);
          },
          child: Container(
            width: widget.switchWidth ?? 45.0,
            height: widget.switchHeight ?? 28.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.SHADOW_COLOR.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  )
                ]),
            child: Container(
              width: widget.switchWidth ?? 45.0,
              height: widget.switchHeight ?? 28.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: !widget.value
                    ? Colors.white
                    : widget.activeColor ?? Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 2.0, bottom: 2.0, right: 4.0, left: 4.0),
                child: Container(
                  alignment: widget.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: widget.thumbSize ?? 20,
                    height: widget.thumbSize ?? 20,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: ColorConstants.SHADOW_COLOR.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      )
                    ], shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
