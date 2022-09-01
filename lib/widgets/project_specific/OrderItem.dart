import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AssetConstants.dart';
import 'package:tfms_delivery_user_app/models/OrderDetailsModel.dart';
import 'package:tfms_delivery_user_app/pages/home/OrderDetailsPage.dart';
import 'package:tfms_delivery_user_app/utils/ViewUtils.dart';

class OrderItems extends StatelessWidget {
  final OrderDetailsModel orderModel;

  const OrderItems({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderDetailPage(orderDetailsModel: orderModel));
      },
      child: Container(
        decoration: ViewUtils.listItemDecoration,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                  decoration: ViewUtils.listItemDecoration,
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(AssetConstants.PIZZA_IMAGE))),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _detailWidget(
                          'Order ID : ', (orderModel.orderId ?? 0).toString()),
                      const SizedBox(height: 6),
                      _detailWidget(
                          'Pickup : ', orderModel.pickupAddress ?? ''),
                      const SizedBox(height: 6),
                      _detailWidget(
                          'Deliver : ', orderModel.deliverAddress ?? ''),
                    ]),
              ),
              const SizedBox(width: 6),
              SvgPicture.asset(AssetConstants.FORWARD_ARROW_ICON),
            ],
          ),
        ),
      ),
    );
  }

  _detailWidget(String title, String value) {
    return Row(
      children: [
        Text(title,
            style:
                Get.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                Get.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
