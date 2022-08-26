import 'package:flutter/services.dart';

class InputUtils {
  static TextInputFormatter lengthFormatter(int length) =>
      LengthLimitingTextInputFormatter(length);

  static TextInputFormatter decimalFormatter() =>
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  static TextInputFormatter mobileNoFormatter() =>
      FilteringTextInputFormatter.allow(RegExp('^[+]{0,1}[0-9]*'));

  static TextInputFormatter percentageFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final percentage = (num.tryParse(newValue.text) ?? 0);
      if (newValue.text.isNotEmpty && (percentage > 100 || percentage <= 0)) {
        return oldValue;
      }
      return newValue;
    });
  }
}
