import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/cart_controller.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/view/pages/cart/widgets/changeaddress.dart';
import 'package:ila/app/view/pages/cart/widgets/checkout_widget.dart';
import 'package:ila/app/view/pages/cart/widgets/order_detail_widget.dart';
import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/custom_text.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final UserController userController = Get.put(UserController());
  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    log("Active${cartController.activeRestaurantID}");
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
          
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeightBox10,
                  const CustomText(
                    text: "My Cart Items",
                    size: 24,
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
                  OrderDetailWidget(),
                ],
              ),
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "DELIVERY ADDRESS",
              color:Get.isDarkMode ? kOffBlue: kGrey,
              size: 15,
            ),
            Obx(() => SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: CustomText(
                    text: userController.userModel
                        .address![homeController.primaryAddressIndex.value],
                    color:Get.isDarkMode ? kOffBlue: kGreyDark,
                    size: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
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
    );
  }
}
