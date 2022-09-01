import 'dart:async';

import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/api/DioClient.dart';
import 'package:tfms_delivery_user_app/dialogs/InfoDialog.dart';
import 'package:tfms_delivery_user_app/models/OrderCategoryModel.dart';
import 'package:tfms_delivery_user_app/models/OrderDetailsModel.dart';

class HomeController extends GetxController {
  final RxBool _showProgress = false.obs;
  bool get showProgress => _showProgress.value;
  set showProgress(val) => _showProgress.value = val;

  final RxBool _isSwitchOn = false.obs;
  bool get isSwitchOn => _isSwitchOn.value;
  set setIsSwitchOn(val) => _isSwitchOn.value = val;

  final RxList<OrderCategoryModel> _orderCategoryList = dummyOrderCatList.obs;
  List<OrderCategoryModel> get orderCategoryList => _orderCategoryList;

  final RxList<OrderDetailsModel> _allOrderList = <OrderDetailsModel>[].obs;
  List<OrderDetailsModel> get allOrderList => _allOrderList;

/*
  List<OrderDetailsModel> get ongoingOrdersList =>
      _allOrderList.where((e) => !(e.orderStatus == 'Ongoing')).toList();

  List<OrderDetailsModel> get deliveredOrdersList =>
      _allOrderList.where((e) => !(e.orderStatus == 'Delivered')).toList();
*/

  final RxList<OrderDetailsModel> _ongoingOrdersList =
      <OrderDetailsModel>[].obs;
  List<OrderDetailsModel> get ongoingOrdersList => _ongoingOrdersList;

  final RxList<OrderDetailsModel> _deliveredOrdersList =
      <OrderDetailsModel>[].obs;
  List<OrderDetailsModel> get deliveredOrdersList => _deliveredOrdersList;

  Future<void> getOngoingOrders() async {
    try {
      _showProgress.value = true;
      _ongoingOrdersList.value = dummyOngoingOrderList;
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> getDeliveredOrders() async {
    try {
      _showProgress.value = true;
      _deliveredOrdersList.value = dummyDeliveredOrdersList;
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> changeOrderOnWayStatus(
      OrderDetailsModel orderDetailsModel) async {
    try {
      _showProgress.value = true;
      Get.dialog(const InfoDialog(msg: 'Status Updated'));
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }

  Future<void> changeOrderDeliveredStatus(
      OrderDetailsModel orderDetailsModel) async {
    try {
      _showProgress.value = true;
      int index = allOrderList.indexOf(orderDetailsModel);
      _allOrderList[index].orderStatus = 'Delivered';
    } catch (e) {
      showError(e);
    } finally {
      _showProgress.value = false;
    }
  }
}
