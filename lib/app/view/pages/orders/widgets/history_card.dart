import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    required this.orderController, required this.index,
  });

  final int index;
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
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        restaurant.image!),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8)),
                ),
              ),
              kWidthBox15,
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        CustomText(
                          text: order.isDelivered!
                              ? "Completed"
                              : "Cancelled",
                          size: 16,
                          weight: FontWeight.bold,
                          color: order.isDelivered!
                              ? kGreen
                              : kWarning,
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
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
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
                            text: DateFormat(
                                    '\tdd  MMM,hh:mm a ')
                                .format(
                                   order.createdAt!)),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: ShapeDecoration(
                            color: kGrey,
                            shape: const OvalBorder(),
                          ),
                        ),
                        CustomText(
                          text: ' ${order.productIds!.length} Items',
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
          order.isDelivered!
              ? orderController.ratingStatusDummy
                      .containsKey(index)
                  ? RatingBarIndicator(
                      rating: orderController
                          .ratingStatusDummy[index],
                      itemBuilder: (context, _) =>
                          Icon(
                        Icons.star,
                        color: kGreen,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                    )
                  : Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Rate Now",
                          size: 14,
                          weight: FontWeight.bold,
                          color: kOrange,
                        ),
                        kWidthBox15,
                        RatingBar(
                            glow: false,
                            allowHalfRating: true,
                            itemSize: 20,
                            ratingWidget:
                                RatingWidget(
                                    full: Icon(
                                        Icons.star,
                                        color:
                                            kOrange),
                                    half: Icon(
                                      Icons.star_half,
                                      color: kOrange,
                                    ),
                                    empty: Icon(
                                      Icons
                                          .star_outline,
                                      color: kBlack,
                                    )),
                            onRatingUpdate: (value) {
                              orderController
                                  .setRating(value);
                              log(orderController
                                  .selectedRating
                                  .toString());
                              Get.dialog(AlertDialog(
                                surfaceTintColor:
                                    kWhite,
                                elevation: 0,
                                content:
                                    SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const CustomText(
                                        text:
                                            "Review Restuarant",
                                        size: 18,
                                        weight:
                                            FontWeight
                                                .bold,
                                      ),
                                      kHeightBox10,
                                      TextFormField(
                                        maxLines: 3,
                                        minLines: 1,
                                        decoration:
                                            const InputDecoration(
                                          // border: OutlineInputBorder(borderSide: BorderSide(color: kBlueShade)),
                                          hintText:
                                              "Tell us your opinion",

                                          labelText:
                                              "Tell us your opinion",
                                        ),
                                        controller:
                                            orderController
                                                .reviewTextController,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        orderController
                                            .addReview(
                                                index);
                                        orderController
                                            .setratingstatus(
                                                index);
                                        Get.back();
                                      },
                                      child:
                                          const CustomText(
                                        text:
                                            "Submit",
                                        weight:
                                            FontWeight
                                                .bold,
                                        size: 16,
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        orderController
                                            .setratingstatus(
                                                index);
                                        Get.back();
                                      },
                                      child:
                                          CustomText(
                                        text: "Skip",
                                        size: 16,
                                        color:
                                            kOrange,
                                      ))
                                ],
                              ));
                            })
                      ],
                    )
              : Container(),
        ],
      ),
    );
  }
}