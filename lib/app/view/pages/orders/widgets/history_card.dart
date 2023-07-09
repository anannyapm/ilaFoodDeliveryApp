import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controller/order_controller.dart';
import '../../../../model/order_model.dart';
import '../../../../model/restaurant_model.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/custom_text.dart';

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget({
    super.key,
    required this.restaurant,
    required this.order,
    required this.orderController,
    required this.index,
  });

  final int index;
  final RestuarantModel restaurant;
  final OrderModel order;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    orderController.ratingStatus.value = order.isRated!;
    log(orderController.ratingStatus.value.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: order.orderStatus=="delivered" ? "Completed" : "Cancelled",
                          size: 16,
                          weight: FontWeight.bold,
                          color: order.orderStatus=="delivered" ? kGreen : kWarning,
                        ),
                        CustomText(
                          text: "#${order.orderId}",
                        ),
                      ],
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
                          text: '₹${order.total!.toInt()}\t',
                          color: kBlueShade,
                          size: 15,
                          weight: FontWeight.w700,
                        ),
                        CustomText(
                          text: "|",
                          size: 22,
                          color: kGrey,
                        ),
                        CustomText(
                            text: DateFormat('\tdd  MMM,hh:mm a ')
                                .format(order.createdAt!)),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: ShapeDecoration(
                            color: kGrey,
                            shape: const OvalBorder(),
                          ),
                        ),
                        CustomText(
                          text: ' ${order.products!.length} Items',
                          color: kGreyDark,
                          size: 15,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          kHeightBox20,
          order.orderStatus=="delivered"
              ?
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  orderController.ratingStatus.value
                        ? CustomText(
                            text: "Rating Added",
                            size: 14,
                            weight: FontWeight.bold,
                            color: kOrange,
                          )
                        : CustomText(
                            text: "Rate Now",
                            size: 14,
                            weight: FontWeight.bold,
                            color: kOrange,
                          ),
                    kWidthBox15,
                    orderController.ratingStatus.value
                        ? RatingBarIndicator(
                            rating: restaurant.rating!.toDouble(),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: kGreen,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                          )
                        : RatingBar(
                            glow: false,
                            allowHalfRating: true,
                            itemSize: 20,
                            ratingWidget: RatingWidget(
                                full: Icon(Icons.star, color: kOrange),
                                half: Icon(
                                  Icons.star_half,
                                  color: kOrange,
                                ),
                                empty: Icon(
                                  Icons.star_outline,
                                  color: kBlack,
                                )),
                            onRatingUpdate: (value) {
                              //
                              //orderController.setRating(value);

                              Get.dialog(AlertDialog(
                                surfaceTintColor: kWhite,
                                elevation: 0,
                                title: CustomText(
                                  text: "Would you like to submit rating?",
                                  size: 16,
                                  weight: FontWeight.bold,
                                  color: kBlueShade,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        await orderController.addRating(
                                            value, order);

                                        orderController.ratingStatus.value =
                                            false;
                                        Get.back();
                                      },
                                      child: const CustomText(text: "Yes")),
                                  TextButton(
                                      onPressed: () async {
                                        Get.back();
                                      },
                                      child: const CustomText(text: "No"))
                                ],
                              ));
                            })
                  ],
                )
              //)

              : Container(),
        ],
      ),
    );
  }
}
