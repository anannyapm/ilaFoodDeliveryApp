import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/cartcontroller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/restaurants/widgets/header_card.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../../controller/homecontroller.dart';
import '../../../../model/product_model.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/custom_button.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;

  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());

  ProductPage({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final String rName =
        homeController.getrestaurantName(product.restaurantId!);
    cartController.isAdded.value = cartController.cartList.contains(product);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: kBlueShade)),
                child: CustomText(
                  text: rName,
                  size: 16,
                ),
              ),
              kHeightBox20,
              CustomText(
                text: product.name!,
                size: 24,
                weight: FontWeight.bold,
              ),
              Expanded(
                child: CustomText(
                    text: product.description!, size: 15, color: kBlueShade),
              ),
              kHeightBox20,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "₹${product.price.toString()}",
                        size: 30,
                      ),
                      Container(
                        width: 135,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: kBlack),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 14,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(kGreylight)),
                              icon: Icon(
                                Icons.remove,
                                color: kWhite,
                              ),
                              onPressed: () {
                                if (homeController.itemCount.value > 0) {
                                  homeController.itemCount.value--;
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Obx(
                                () => CustomText(
                                  text:
                                      homeController.itemCount.value.toString(),
                                  size: 18,
                                  color: kWhite,
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 14,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(kGreylight)),
                              icon: Icon(
                                Icons.add,
                                color: kWhite,
                              ),
                              onPressed: () {
                                homeController.itemCount.value++;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: Obx(() => CustomButton(
                      padding: 15,
                      text: CustomText(
                        text: cartController.isAdded.value
                            ? "REMOVE FROM CART"
                            : "ADD TO CART",
                        color: kWhite,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      function: () {
                        if (cartController.isAdded.value) {
                          cartController.removeFromCart(product);
                        } else {
                          cartController.addToCart(product);
                        }
                        cartController.isAdded.value =
                            !cartController.isAdded.value;
                      },
                      color:cartController.isAdded.value?kWarning: kGreen)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
