import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewUtils {
  static removeFocus() {
    if (MediaQuery.of(Get.context!).viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    }
  }

  static Widget get anonymousAvatar => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.white, width: 1)),
        child: const CircleAvatar(
          radius: 20,
          child: Icon(Icons.person_outline_sharp, color: Colors.white),
          backgroundColor: Colors.indigo,
        ),
      );

  static Color generateColorByIndex(int i) {
    return Colors.primaries[i > 15 ? (i % 15) : i];
  }

  static Future<void> showCupertinoDatePicker(
      {required Function(DateTime) onDateSelected,
      bool isTimePicker = false,
      bool isDateTimePicker = false,
      DateTime? initialDate,
      DateTime? firstDate,
      DateTime? lastDate,
      String title = '',
      VoidCallback? onDismissed}) async {
    DateTime dt = initialDate ?? DateTime.now();
    if (firstDate != null && initialDate != null) {
      bool isSame = firstDate.isAfter(initialDate);
      if (isSame) {
        initialDate = firstDate.add(const Duration(minutes: 1));
        dt = initialDate;
      }
    }
    showCupertinoModalPopup(
        context: Get.context!,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: title.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child:
                                  Text(title, style: Get.textTheme.subtitle1),
                            )
                          : Container(),
                    ),
                    const SizedBox(width: 4),
                    CupertinoButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Get.back();
                        onDateSelected(dt);
                        onDismissed?.call();
                        FocusScope.of(Get.context!).requestFocus(FocusNode());
                      },
                    )
                  ],
                ),
                const Divider(height: 1),
                SizedBox(
                  height: Get.height / 3,
                  child: CupertinoDatePicker(
                      mode: isDateTimePicker
                          ? CupertinoDatePickerMode.dateAndTime
                          : (isTimePicker
                              ? CupertinoDatePickerMode.time
                              : CupertinoDatePickerMode.date),
                      minimumDate: firstDate,
                      maximumDate: lastDate,
                      initialDateTime: initialDate,
                      onDateTimeChanged: (val) {
                        dt = val;
                      }),
                ),
              ],
            ),
          );
        });
  }
}
