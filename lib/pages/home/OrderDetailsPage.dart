import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/constants/AssetConstants.dart';
import 'package:tfms_delivery_user_app/controller/HomeController.dart';
import 'package:tfms_delivery_user_app/models/OrderDetailsModel.dart';
import 'package:tfms_delivery_user_app/utils/ViewUtils.dart';
import 'package:tfms_delivery_user_app/widgets/DrawerAppBarWidget.dart';
import 'package:tfms_delivery_user_app/widgets/core/RoundedButton.dart';
import 'package:tfms_delivery_user_app/widgets/project_specific/StoreNavigatorWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderDetailsModel orderDetailsModel;

  const OrderDetailPage({Key? key, required this.orderDetailsModel})
      : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final _homeController = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        appBar: DrawerAppBarWidget(
            title: 'Order Detail',
            leadingIcon: Icons.arrow_back_ios,
            leadingCallback: () {
              Get.back();
            },
            toggleSwitchCallback: (value) {
              _homeController.setIsSwitchOn = value;
            },
            switchValue: _homeController.isSwitchOn),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              //Order Details
              Container(
                width: Get.width,
                decoration: ViewUtils.listItemDecoration,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID: ${widget.orderDetailsModel.orderId ?? 0}',
                        style: Get.textTheme.subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Items',
                        style: Get.textTheme.subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    _orderItemsList(),
                    const Divider(height: 10, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Get.textTheme.subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${widget.orderDetailsModel.totalAmount ?? 0}',
                          style: Get.textTheme.subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              //Pickup Details
              _pickupDeliverWidget(
                  title: 'Pickup',
                  label: widget.orderDetailsModel.pickupPlaceName,
                  address: widget.orderDetailsModel.pickupAddress,
                  mobileNumber: widget.orderDetailsModel.pickupMobileNumber,
                  lat: widget.orderDetailsModel.pickupLatitude,
                  lng: widget.orderDetailsModel.pickupLongitude,
                  orderStatus: widget.orderDetailsModel.orderStatus),

              //Deliver Details
              _pickupDeliverWidget(
                  title: 'Deliver',
                  label: widget.orderDetailsModel.customerName,
                  address: widget.orderDetailsModel.deliverAddress,
                  mobileNumber: widget.orderDetailsModel.deliverMobileNumber,
                  lat: widget.orderDetailsModel.deliverLatitude,
                  lng: widget.orderDetailsModel.deliverLongitude,
                  orderStatus: widget.orderDetailsModel.orderStatus),

              const SizedBox(height: 40),
              widget.orderDetailsModel.orderStatus != 'Delivered'
                  ? widget.orderDetailsModel.orderStatus == 'Ongoing'
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoundedButton(
                            onPressed: () {
                              _homeController.changeOrderOnWayStatus(
                                  widget.orderDetailsModel);
                            },
                            isExpanded: true,
                            enabledColor: ColorConstants.DARK_BLUE_COLOR,
                            text: 'Order on the way',
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RoundedButton(
                            onPressed: () {
                              _homeController.changeOrderDeliveredStatus(
                                  widget.orderDetailsModel);
                            },
                            isExpanded: true,
                            enabledColor: ColorConstants.GREEN_COLOR,
                            text: 'Order Delivered',
                          ),
                        )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.orderDetailsModel.orderedItems?.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                  decoration: ViewUtils.listItemDecoration,
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(AssetConstants.PIZZA_IMAGE))),
              const SizedBox(width: 10),
              Text(
                '${widget.orderDetailsModel.orderedItems?[index].quantity ?? 0}   ${widget.orderDetailsModel.orderedItems?[index].foodItemName ?? ''}',
                style: Get.textTheme.bodyText1
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Text(
                  '\$${widget.orderDetailsModel.orderedItems?[index].price ?? 0}',
                  style: Get.textTheme.bodyText1
                      ?.copyWith(fontWeight: FontWeight.w400)),
            ],
          ),
        );
      },
    );
  }

  Widget _pickupDeliverWidget(
      {String? title,
      String? label,
      String? address,
      String? mobileNumber,
      double? lat,
      double? lng,
      String? orderStatus}) {
    return Container(
      width: Get.width,
      decoration: ViewUtils.listItemDecoration,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '',
                  style: Get.textTheme.subtitle1
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              orderStatus != 'Delivered'
                  ? RoundedButton(
                      height: 34,
                      onPressed: () {
                        _makePhoneCall('tel:${mobileNumber ?? ''}');
                      },
                      enabledColor: ColorConstants.GREEN_COLOR,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      radius: 6,
                      child: _iconBtn(AssetConstants.CALL_ICON, 'Call'))
                  : const SizedBox(),
              const SizedBox(width: 10),
              orderStatus != 'Delivered'
                  ? RoundedButton(
                      height: 34,
                      onPressed: () {
                        Get.bottomSheet(
                          StoreNavigatorWidget(
                            lat: lat ?? 0.0,
                            lng: lng ?? 0.0,
                          ),
                        );
                      },
                      enabledColor: ColorConstants.BLUE_COLOR,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      radius: 6,
                      child:
                          _iconBtn(AssetConstants.DIRECTION_ICON, 'Direction'))
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: orderStatus == 'Delivered' ? 10 : 0),
          Text(label ?? '',
              style: Get.textTheme.subtitle2
                  ?.copyWith(fontWeight: FontWeight.w400)),
          const SizedBox(height: 6),
          Text(
            address ?? '',
            style:
                Get.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  _iconBtn(String icon, String title) {
    return Row(
      children: [
        SvgPicture.asset(icon, height: 16),
        const SizedBox(width: 4),
        Text(
          title,
          style: Get.textTheme.subtitle2
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
        )
      ],
    );
  }

  Future<void> _makePhoneCall(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      throw 'Could not launch $url';
    }
  }
}
