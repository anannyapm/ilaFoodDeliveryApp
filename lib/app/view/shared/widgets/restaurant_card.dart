import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/restaurant_model.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../controller/home_controller.dart';

class RestaurantCard extends StatelessWidget {
  final RestuarantModel restaurant;
  /* final String imageUrl;
  final String rName;
  final String rTag; */
  final VoidCallback onTap;
  /*  final String deliveryCharge;
  final String deliveryTime;
  final num rate;
  final bool isFav; */

  const RestaurantCard({
    super.key,
   
    required this.onTap,
    required this.restaurant,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 260,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        surfaceTintColor: kWhite,
        color: kWhite,
        elevation: 4,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      /* image: DecorationImage(
                        image: NetworkImage(restaurant.image!),
                        fit: BoxFit.cover,
                      ) */),
                      child: ClipRRect(
                          borderRadius:BorderRadius.circular(8),
                          child: FadeInImage(
      fadeInDuration: const Duration(milliseconds: 300),
                            placeholder: const AssetImage('assets/images/placeholder.jpg'),
                            image:NetworkImage(restaurant.image!),
                            fit: BoxFit.cover,
                            ), )
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kBlack.withOpacity(0.2)),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GetBuilder<HomeController>(
                      init: HomeController(),
                      builder: (controller) {
                        return IconButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kWhite)),
                            onPressed: () async {
                              log("pressed favorite button");
                              await controller
                                  .updateFavoriteStatus(restaurant.docId);
                            },
                            icon: Obx(() => Icon(
                                  Icons.favorite,
                                  color: controller.favList
                                              .contains(restaurant.docId) ==
                                          true
                                      ? kGreen
                                      : kGreyDark,
                                )));
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 30,
                        width: 65,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: kOrange,
                              ),
                              kWidthBox10,
                              CustomText(
                                text: restaurant.rating.toString(),
                                weight: FontWeight.bold,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      )),
                )
              ]),
              kHeightBox10,
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      overflow: TextOverflow.ellipsis,
                      text: restaurant.name!,
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text: restaurant.tagline!,
                      size: 14,
                      color: kBlueShade,
                    ),
                    kHeightBox10,
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              color: kGreen,
                              size: 25,
                            ),
                            kWidthBox15,
                            CustomText(
                              text: restaurant.deliveryfee.toString() == '0'
                                  ? "Free Delivery"
                                  : "Charge - ₹${restaurant.deliveryfee.toString()}",
                              size: 16,
                            ),
                          ],
                        ),
                        kWidthBox20,
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: kGreen,
                              size: 22,
                            ),
                            kWidthBox15,
                            CustomText(
                              text: restaurant.deliverytime!,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
