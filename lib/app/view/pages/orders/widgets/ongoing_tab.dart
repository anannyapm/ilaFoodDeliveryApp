import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/order_controller.dart';
import 'package:ila/app/model/order_model.dart';
import 'package:ila/app/model/restaurant_model.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/empty_widet.dart';
import 'ongoing_card.dart';

class OngoingTab extends StatelessWidget {
  final OrderController orderController;
  const OngoingTab({super.key, required this.orderController});

  @override
  Widget build(BuildContext context) {
    // log(Timestamp.fromDate(DateTime.now()).toString());
    return SingleChildScrollView(
      child: Obx(() => Container(
            margin: const EdgeInsets.all(15),
            child: orderController.isOrdersLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : orderController.ongoingOrders.isEmpty
                    ? const EmptyWidget()
                    : Column(
                        children: [
                          Obx(() => ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: orderController.ongoingOrders.length,
                                itemBuilder: (context, index) {
                                  OrderModel order =
                                      orderController.ongoingOrders[index];
                                  RestuarantModel restaurant = homeController
                                      .getrestaurant(order.restaurantId!);
                                  return OngoingCardWidget(restaurant: restaurant, order: order, orderController: orderController);
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                              )),
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

