import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoItemsWidget extends StatelessWidget {
  final String text;
  const NoItemsWidget(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 52),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.emoji_people_outlined,
              size: 40, color: Get.theme.primaryColor),
          const SizedBox(height: 12),
          Text(text,
              textAlign: TextAlign.center,
              style: Get.textTheme.subtitle1!.copyWith(
                  color: Get.theme.primaryColor, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
