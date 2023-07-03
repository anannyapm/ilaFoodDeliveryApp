import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/cart_controller.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/view/pages/cart/widgets/changeaddress.dart';
import 'package:ila/app/view/pages/cart/widgets/checkout_widget.dart';
import 'package:ila/app/view/pages/cart/widgets/order_detail_widget.dart';
import 'package:ila/app/view/shared/widgets/close_widget.dart';
import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/custom_text.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final UserController userController = Get.put(UserController());
  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.find();
  //final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    log("Active${cartController.activeRestaurantID}");
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeightBox10,
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    CloseWidget(),
                    CustomText(
                      text: "My Cart Items",
                      size: 20,
                    ),
                  ],
                ),
              ),
              kHeightBox20,
              AddressDetailWidget(
                  userController: userController,
                  homeController: homeController),
              kHeightBox20,
              Obx(() => cartController.totalCount == 0
                  ? Container()
                  : const CheckoutDetailWidget()),
              kHeightBox20,
              Expanded(child: OrderDetailWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressDetailWidget extends StatelessWidget {
  const AddressDetailWidget({
    super.key,
    required this.userController,
    required this.homeController,
  });

  final UserController userController;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "DELIVERY ADDRESS",
                color: kGrey,
                size: 15,
              ),
              Obx(() => CustomText(
                    text: userController.userModel
                        .address![homeController.primaryAddressIndex.value],
                    color: kGreyDark,
                    size: 16,
                  )),
            ],
          ),
          TextButton(
              onPressed: () => showChangeAddressBottomSheet(),
              child: CustomText(
                text: "CHANGE",
                color: kOrange,
                size: 14,
                weight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
