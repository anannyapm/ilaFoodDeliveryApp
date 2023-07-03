import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/orders/widgets/history_tab.dart';
import 'package:ila/app/view/pages/orders/widgets/ongoing_tab.dart';

import '../../../controller/order_controller.dart';
import '../../shared/widgets/custom_text.dart';

class OrdersPage extends StatelessWidget {
   OrdersPage({super.key});
  final OrderController orderController = Get.put(OrderController());


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeightBox20,
              const Padding(
                padding: EdgeInsets.all(15),
                child: CustomText(
                  text: "My Orders",
                  size: 24,
                ),
              ),
              kHeightBox10,
              const TabBar(indicatorSize: TabBarIndicatorSize.tab, tabs: [
                Tab(
                  text: "Ongoing",
                ),
                Tab(
                  text: "History",
                ),
              ]),
              Expanded(
                  child:
                      TabBarView(children: [ OngoingTab(orderController: orderController,), HistoryTab(orderController: orderController,)]))
            ],
          ),
        ),
      ),
    );
  }
}
