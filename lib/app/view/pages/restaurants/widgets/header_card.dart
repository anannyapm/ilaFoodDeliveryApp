import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/cart_controller.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/navigation_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

class HeaderCard extends StatelessWidget {
  final String imageUrl;
  final num? rate;
  final bool isFav;
  final bool isProduct;
  final String itemid;

  HeaderCard({
    super.key,
    required this.imageUrl,
    required this.rate,
    required this.isFav,
    required this.isProduct,
    required this.itemid,
  });

  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.find();
  final NavigationController navigationController =
      Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        surfaceTintColor: Get.isDarkMode ? kGrey.withOpacity(0.6) : kWhite,
        color: Get.isDarkMode ? kGrey.withOpacity(0.6) : kWhite,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: isProduct
                    ? MediaQuery.of(context).size.height * 0.45
                    : MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 300),
                    placeholder:
                        const AssetImage('assets/images/placeholder.jpg'),
                    image: NetworkImage(imageUrl),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                      'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: isProduct
                    ? MediaQuery.of(context).size.height * 0.45
                    : MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Get.isDarkMode
                        ? kGrey.withOpacity(0)
                        : kBlack.withOpacity(0.2)),
              ),
              !isProduct
                  ? Positioned(
                      right: 16,
                      bottom: 16,
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
                                  await controller.updateFavoriteStatus(itemid);
                                },
                                icon: Obx(() => Icon(
                                      Icons.favorite,
                                      color: controller.favList.contains(itemid)
                                          ? kGreen
                                          : Get.isDarkMode
                                              ? kWhite
                                              : kGreyDark,
                                    )));
                          },
                        ),
                      ),
                    )
                  : Container(),
              Positioned(
                top: 16,
                left: 16,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(kWhite)),
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                      )),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      navigationController.setSelectedIndex(4);

                      Get.to(() => NavigationPage());
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundColor: kWhite,
                            child: const Icon(Icons.shopping_bag_outlined)),
                        Positioned(
                            bottom: -1,
                            right: -1,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: kOrange,
                              child: Obx(() => CustomText(
                                    text: cartController.totalCount.toString(),
                                    size: 12,
                                    color: kWhite,
                                  )),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              rate == null
                  ? Container()
                  : Positioned(
                      bottom: 16,
                      left: 16,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: kOrange,
                                  ),
                                  kWidthBox10,
                                  CustomText(
                                    text: rate.toString(),
                                    weight: FontWeight.bold,
                                    size: 16,
                                    color: kBlack,
                                  )
                                ],
                              ),
                            ),
                          )),
                    )
            ]),
          ],
        ),
      ),
    );
  }
}
