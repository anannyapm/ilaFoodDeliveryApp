
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/order_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../../model/order_model.dart';
import '../../../../model/restaurant_model.dart';
import '../../../../utils/constants/controllers.dart';
import '../../../shared/widgets/empty_widet.dart';
import 'history_card.dart';

class HistoryTab extends StatelessWidget {
  final OrderController orderController;

  const HistoryTab({super.key, required this.orderController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(15),
          child: Obx(
            () => orderController.isOrdersLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : orderController.oldOrders.isEmpty
                    ? const EmptyWidget()
                    : Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orderController.oldOrders.length,
                            itemBuilder: (context, index) {
                              OrderModel order =
                                  orderController.oldOrders[index];
                              RestuarantModel restaurant = homeController
                                  .getrestaurant(order.restaurantId!);
                              return HistoryCardWidget(restaurant: restaurant, order: order, orderController: orderController,index:index);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                          ),
                          const Divider(),
                          kHeightBox10,
                          Center(
                            child: CustomText(
                              text: "No More Orders",
                              size: 15,
                              color: kGrey,
                            ),
                          )
                        ],
                      ),
          )),
    );
  }
}


