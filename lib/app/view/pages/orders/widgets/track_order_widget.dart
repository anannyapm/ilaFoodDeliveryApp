import 'package:flutter/material.dart';
import 'package:ila/app/model/restaurant_model.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/pages/orders/widgets/track_widget.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../model/order_model.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/custom_text.dart';

class TrackOrderWidget extends StatelessWidget {
  final RestuarantModel restaurant;
  final OrderModel order;
  const TrackOrderWidget(
      {super.key, required this.restaurant, required this.order});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            kHeightBox20,
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: ShapeDecoration(
                    /* image: DecorationImage(
                      image: NetworkImage(restaurant.image!),
                      fit: BoxFit.fill,
                    ), */
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: ClipRRect(
                          borderRadius:BorderRadius.circular(8),
                          child: FadeInImage(
      fadeInDuration: const Duration(milliseconds: 300),
                            placeholder: const AssetImage('assets/images/placeholder.jpg'),
                            image:NetworkImage(restaurant.image!),
                            fit: BoxFit.cover,), )
                ),
                kWidthBox15,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: restaurant.name!,
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text:
                          "Ordered At ${DateFormat('dd  MMM,hh:mm a ').format(order.createdAt!)}",
                      color: kGrey,
                      size: 16,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: '₹${order.total!.toInt()}',
                          color: kBlueShade,
                          size: 15,
                          weight: FontWeight.w700,
                        ),
                        kWidthBox15,
                        CustomText(
                          text: "|",
                          size: 22,
                          color: kGrey,
                        ),
                        kWidthBox15,
                        CustomText(
                          text: '${order.products!.length} Items',
                          color: kGreyDark,
                          size: 15,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            kHeightBox20,
            CustomText(
              text: "${restaurant.deliverytime} Min",
              size: 30,
              weight: FontWeight.w800,
            ),
            CustomText(
              text: "ESTIMATED DELIVERY TIME",
              size: 14,
              weight: FontWeight.w400,
              color: kGrey,
            ),
            kHeightBox20,
            TrackWidget(
                currentStage: orderController.getOrderCurrentStatus(order)),
            kHeightBox20,
            const Divider(),
            (order.orderStatus == 'outForDelivery' ||
                    order.orderStatus == 'arrivingSoon')
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://cdn-icons-png.flaticon.com/512/305/305976.png"),
                            ),
                            kWidthBox15,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: order.deliveryPersonName!,
                                  color: kBlueShade,
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: "Delivery Person",
                                  color: kGrey,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            orderController
                                .makePhoneCall(order.deliveryPersonPhone!);
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: kBlueShade),
                            child: Icon(
                              Icons.call_outlined,
                              color: kWhite,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Deliciousness in the making !",
                        weight: FontWeight.bold,
                        size: 18,
                        color: kBlueShade,
                      ),
                      Lottie.asset('assets/animations/loadfood.json',
                          height: 150),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
