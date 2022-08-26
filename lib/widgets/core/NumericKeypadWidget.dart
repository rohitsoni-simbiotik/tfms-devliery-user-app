import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/AppConstants.dart';

class NumericKeypadWidget extends StatefulWidget {
  final int length;
  final Function(String)? onChanged;
  const NumericKeypadWidget({Key? key, this.length = 999, this.onChanged})
      : super(key: key);

  @override
  State<NumericKeypadWidget> createState() => _NumericKeypadWidgetState();
}

class _NumericKeypadWidgetState extends State<NumericKeypadWidget> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (i) => DigitWidget(
                    digit: i + 1,
                    onPress: () => onPush('${i + 1}'),
                  )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (i) => DigitWidget(
                    digit: i + 4,
                    onPress: () => onPush('${i + 4}'),
                  )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (i) => DigitWidget(
                    digit: i + 7,
                    onPress: () => onPush('${i + 7}'),
                  )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DigitWidget(
              child: Container(),
              color: Colors.transparent,
            ),
            DigitWidget(
              digit: 0,
              onPress: () => onPush('0'),
            ),
            DigitWidget(
                digit: 0,
                onPress: () => onPop(),
                color: Colors.transparent,
                child:
                    const Icon(Icons.backspace, color: ColorConstants.PRIMARY))
          ],
        ),
      ],
    );
  }

  void onPush(String v) {
    if (_value.length < widget.length) {
      _value = '$_value$v';
    }
    widget.onChanged?.call(_value);
  }

  void onPop() {
    if (_value.length > 1) {
      _value = _value.substring(0, _value.length - 1);
    } else {
      _value = '';
    }
    widget.onChanged?.call(_value);
  }
}

class DigitWidget extends StatelessWidget {
  final int digit;
  final Widget? child;
  final Color? color;
  final VoidCallback? onPress;
  const DigitWidget(
      {Key? key, this.digit = 0, this.child, this.color, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onPress,
        child: CircleAvatar(
            child: child ??
                Text(
                  '$digit',
                  style: Get.textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
            backgroundColor: color ?? ColorConstants.PRIMARY,
            radius: 30),
      ),
    );
  }
}
