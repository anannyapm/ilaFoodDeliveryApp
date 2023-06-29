import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/restaurant_model.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/restaurants/pages/product_page.dart';
import 'package:ila/app/view/pages/restaurants/widgets/header_card.dart';
import 'package:ila/app/view/pages/restaurants/widgets/product_card.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/empty_widet.dart';

import '../../../../controller/homecontroller.dart';
import '../../../../model/product_model.dart';
import '../../../../utils/constants/color_constants.dart';

class ViewRestaurantPage extends StatelessWidget {
  final RestuarantModel restaurant;

  final HomeController homeController = Get.put(HomeController());

  ViewRestaurantPage({super.key, required this.restaurant});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderCard(
                  imageUrl: restaurant.image!,
                  rate: restaurant.rating!,
                  isFav: restaurant.isFavorite!,
                  isProduct: false,
                  itemid: restaurant.docId!,
                ),
                kHeightBox20,
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
                          text: restaurant.deliveryfee == 0
                              ? "Free Delivery"
                              : "Charge - ₹${restaurant.deliveryfee}",
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
                kHeightBox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        lines: 2,
                        text: restaurant.name!,
                        size: 24,
                        weight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    CustomText(
                      text: restaurant.isOpen! ? "Open Today" : "Closed Today",
                      size: 16,
                      weight: FontWeight.bold,
                      color: kOrange,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
                kHeightBox10,
                CustomText(
                    text: restaurant.description!, size: 15, color: kGrey),
                kHeightBox20,
                Row(
                  children: [
                    Obx(() => CustomText(
                          text: homeController.isRecommended.value
                              ? "Recommended"
                              : "All Items",
                          size: 18,
                        )),
                    kWidthBox15,
                    Obx(
                      () => Switch(
                        activeTrackColor: kGreen.withOpacity(0.8),
                        trackOutlineColor: MaterialStatePropertyAll(kWhite),
                        value: homeController.isRecommended.value,
                        onChanged: (value) {
                          log(value.toString());
                          homeController.toggleRecommended(value);
                          homeController
                              .getProductFromRestaurant(restaurant.docId);
                        },
                      ),
                    ),
                  ],
                ),
                kHeightBox10,
                Obx(() {
                  homeController.getProductFromRestaurant(restaurant.docId);
                  RxList<ProductModel> productList =
                      homeController.restaurantBasedProducts;

                  return productList.isEmpty
                      ? const EmptyWidget()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: productList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final item = productList[index];
                            return ProductCard(
                                product:item,
                                onTap: () =>
                                    Get.to(() => ProductPage(product: item)));
                          },
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
