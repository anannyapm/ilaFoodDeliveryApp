import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/pages/orders/widgets/track_order_widget.dart';
import 'package:intl/intl.dart';

import '../../../../controller/order_controller.dart';
import '../../../../model/order_model.dart';
import '../../../../model/restaurant_model.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/bordered_box.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text.dart';

class OngoingCardWidget extends StatelessWidget {
  const OngoingCardWidget({
    super.key,
    required this.restaurant,
    required this.order,
    required this.orderController,
  });

  final RestuarantModel restaurant;
  final OrderModel order;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                     
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: ClipRRect(
                          borderRadius:BorderRadius.circular(8),
                          child: FadeInImage(
      fadeInDuration: const Duration(milliseconds: 300),
                            placeholder: const AssetImage('assets/images/placeholder.jpg'),
                            image:NetworkImage(restaurant.image!),
      imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/placeholder.jpg',fit: BoxFit.cover,) ,

                            fit: BoxFit.cover,), )
                  ),
                  kWidthBox15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: DateFormat('dd  MMM,hh:mm a ')
                            .format(order.createdAt!),
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      CustomText(
                        text: restaurant.name!,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: '₹${order.total!.toInt()}',
                            color:Get.isDarkMode?kWhite: kBlueShade,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                          kWidthBox15,
                          CustomText(
                            text: "|",
                            size: 22,
                            color:Get.isDarkMode?kWhite: kGrey,
                          ),
                          kWidthBox15,
                          CustomText(
                            text: '${order.products!.length} Items',
                            color: Get.isDarkMode?kWhite:kGreyDark,
                            size: 15,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              CustomText(
                text: "#${order.orderId}",
                align: TextAlign.right,
              )
            ],
          ),
          kHeightBox20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                height: 45,
                child: CustomButton(
                    padding: 0,
                    text: CustomText(
                      text: "Track Order",
                      color: kWhite,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                    function: () => Get.bottomSheet(
                        TrackOrderWidget(
                          restaurant: restaurant,
                          order: order,
                        ),
                        backgroundColor:Get.isDarkMode?kBlueShade: kWhite,
                        isScrollControlled: true),
                    color: kGreen),
              ),
              SizedBox(
                  width: 150,
                  height: 45,
                  child: BorderedButton(
                    text: CustomText(
                      text: "Cancel",
                      size: 15,
                      weight: FontWeight.bold,
                      color: kOrange,
                    ),
                    color: kOrange,
                    function: () {
                      Get.dialog(AlertDialog(
                        surfaceTintColor:Get.isDarkMode?kBlueShade: kWhite,
                        title: const CustomText(
                          text: "Are you sure you want to Cancel this order?",
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await orderController.onOrderCancel(order);
                                Get.back();
                              },
                              child: CustomText(
                                text: "Yes",
                                weight: FontWeight.bold,
                                size: 15,
                                color: kWarning,
                              )),
                          TextButton(
                              onPressed: () => Get.back(),
                              child: CustomText(
                                text: "No",
                                weight: FontWeight.bold,
                                size: 15,
                                color:Get.isDarkMode?kWhite: kBlueShade,
                              ))
                        ],
                      ));
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}
