import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfms_delivery_user_app/constants/AppConstants.dart';
import 'package:tfms_delivery_user_app/controller/HomeController.dart';
import 'package:tfms_delivery_user_app/pages/home/DrawerPage.dart';
import 'package:tfms_delivery_user_app/widgets/DrawerAppBarWidget.dart';
import 'package:tfms_delivery_user_app/widgets/core/ProgressContainerView.dart';
import 'package:tfms_delivery_user_app/widgets/project_specific/OrderItem.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _homeController = Get.find<HomeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        vsync: this, length: _homeController.orderCategoryList.length);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeController.getOngoingOrders();
      _homeController.getDeliveredOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        appBar: DrawerAppBarWidget(
            title: 'Delivery Dashboard',
            leadingCallback: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            toggleSwitchCallback: (value) {
              _homeController.setIsSwitchOn = value;
            },
            switchValue: _homeController.isSwitchOn),
        drawer: const Drawer(child: DrawerPage(drawerIndex: 0)),
        body: WillPopScope(
            onWillPop: () async {
              if (_scaffoldKey.currentState!.isDrawerOpen) {
                Get.back();
                return false;
              } else {
                return true;
              }
            },
            child: _body()),
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: DefaultTabController(
        length: _homeController.orderCategoryList.length,
        child: Column(
          children: <Widget>[
            TabBar(
              controller: _tabController,
              labelStyle: Get.textTheme.subtitle1
                  ?.copyWith(fontWeight: FontWeight.w700),
              unselectedLabelStyle: Get.textTheme.subtitle1
                  ?.copyWith(fontWeight: FontWeight.w400),
              tabs: const [
                Tab(text: "Ongoing Order"),
                Tab(text: "Delivered Orders")
              ],
              indicatorWeight: 1,
              indicatorColor: ColorConstants.PRIMARY,
              labelColor: ColorConstants.PRIMARY,
              unselectedLabelColor: ColorConstants.UNSELECTED_TAB_TEXT,
            ),
            Expanded(
              child: ProgressContainerView(
                isProgressRunning: _homeController.showProgress,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      itemCount: _homeController.ongoingOrdersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderItems(
                            orderModel:
                                _homeController.ongoingOrdersList[index]);
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      itemCount: _homeController.deliveredOrdersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderItems(
                            orderModel:
                                _homeController.deliveredOrdersList[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
