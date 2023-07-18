import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/cart_controller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/restaurants/widgets/header_card.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../../model/product_model.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/controllers.dart';
import '../../../shared/widgets/custom_button.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;

  final CartController cartController = Get.find();

  ProductPage({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    String rName = "";
    final restaurant = homeController.getrestaurant(product.restaurantId!);
    if (restaurant != null) {
      rName = restaurant!.name;
    }
    RxBool isAdded = cartController.isItemAlreadyAdded(product).obs;
    cartController.itemCount.value = 1;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderCard(
                          itemid: product.docId!,
                          isProduct: true,
                          imageUrl: product.image!,
                          rate: null,
                          isFav: product.isRecommended!),
                      kHeightBox20,
                      kHeightBox10,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                        child: SizedBox(
                          //height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Get.isDarkMode
                                            ? kGrey
                                            : kBlueShade)),
                                child: CustomText(
                                  text: rName,
                                  size: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              kHeightBox20,
                              CustomText(
                                text: product.name!,
                                size: 24,
                                weight: FontWeight.bold,
                              ),
                              kHeightBox10,
                              CustomText(
                                  text: product.description!,
                                  size: 15,
                                  color: Get.isDarkMode ? kWhite : kBlueShade),
                              kHeightBox10,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "₹${product.price.toString()}/Item",
                        size: 28,
                      ),
                      Obx(() => cartController.isItemAlreadyAdded(product)
                          ? CustomText(
                              text:
                                  "Quantity : ${cartController.cartList.firstWhere((element) => element.productId == product.docId).quantity}",
                              size: 18,
                              weight: FontWeight.bold,
                            )
                          : Container(
                              width: 150,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Get.isDarkMode ? kWhite : kBlack),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 14,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                kGreylight)),
                                    icon: Icon(
                                      Icons.remove,
                                      color: Get.isDarkMode ? kBlack : kWhite,
                                    ),
                                    onPressed: () {
                                      if (cartController.itemCount.value > 1) {
                                        cartController.itemCount.value--;
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Obx(
                                      () => CustomText(
                                        text: cartController.itemCount.value
                                            .toString(),
                                        size: 18,
                                        color: Get.isDarkMode ? kBlack : kWhite,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 14,
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                kGreylight)),
                                    icon: Icon(
                                      Icons.add,
                                      color: Get.isDarkMode ? kBlack : kWhite,
                                    ),
                                    onPressed: () {
                                      cartController.itemCount.value++;
                                    },
                                  ),
                                ],
                              ),
                            ))
                    ],
                  ),
                ),
                kHeightBox10,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 15, right: 15),
                    child: SizedBox(
                      width: double.infinity,
                      child: Obx(() => CustomButton(
                          padding: 15,
                          text: CustomText(
                            text: isAdded.value
                                ? "REMOVE FROM CART"
                                : "ADD TO CART",
                            color: kWhite,
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                          function: () async {
                            log(isAdded.toString());
                            bool output = false;
                            if (isAdded.value) {
                              output =
                                  await cartController.removeCartItem(product.docId!);
                            } else {
                              output = await cartController.addProductToCart(
                                  product, cartController.itemCount.value);
                            }
                            if (output) {
                              isAdded.value = !isAdded.value;
                            }
                          },
                          color: isAdded.value ? kWarning : kGreen)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
