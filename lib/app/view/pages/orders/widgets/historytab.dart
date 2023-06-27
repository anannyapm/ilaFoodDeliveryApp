import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/ordercontroller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class HistoryTab extends StatelessWidget {
  HistoryTab({super.key});
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
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
                              image: const DecorationImage(
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/604969/pexels-photo-604969.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          kWidthBox15,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: index % 2 == 0
                                          ? "Completed"
                                          : "Cancelled",
                                      size: 16,
                                      weight: FontWeight.bold,
                                      color: index % 2 == 0 ? kGreen : kWarning,
                                    ),
                                    const CustomText(
                                      text: "#1245432",
                                    ),
                                  ],
                                ),
                                const CustomText(
                                  text: "Arabian Hut",
                                  size: 16,
                                  weight: FontWeight.bold,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: '₹580\t',
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
                                            .format(DateTime.now())),
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: ShapeDecoration(
                                        color: kGrey,
                                        shape: const OvalBorder(),
                                      ),
                                    ),
                                    CustomText(
                                      text: ' 03 Items',
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
                      index % 2 == 0
                          ? orderController.ratingStatusDummy.containsKey(index)
                              ? RatingBarIndicator(
                                  rating:
                                      orderController.ratingStatusDummy[index],
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: kGreen,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        ratingWidget: RatingWidget(
                                            full: Icon(Icons.star,
                                                color: kOrange),
                                            half: Icon(
                                              Icons.star_half,
                                              color: kOrange,
                                            ),
                                            empty: Icon(
                                              Icons.star_outline,
                                              color: kBlack,
                                            )),
                                        onRatingUpdate: (value) {
                                          orderController.setRating(value);
                                          log(orderController.selectedRating
                                              .toString());
                                          Get.dialog(AlertDialog(
                                            surfaceTintColor: kWhite,
                                            elevation: 0,
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  const CustomText(
                                                    text: "Review Restuarant",
                                                    size: 18,
                                                    weight: FontWeight.bold,
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
                                                    controller: orderController
                                                        .reviewTextController,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    orderController
                                                        .addReview(index);
                                                    orderController
                                                        .setratingstatus(index);
                                                    Get.back();
                                                  },
                                                  child: const CustomText(
                                                    text: "Submit",
                                                    weight: FontWeight.bold,
                                                    size: 16,
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    orderController
                                                        .setratingstatus(index);
                                                    Get.back();
                                                  },
                                                  child: CustomText(
                                                    text: "Skip",
                                                    size: 16,
                                                    color: kOrange,
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
              },
              separatorBuilder: (context, index) => const Divider(),
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
      ),
    );
  }
}
