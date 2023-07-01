import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/payment_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/cart/widgets/paymentoption.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../shared/widgets/custom_button.dart';

void showOrderSummarySheet() {
  UserController userController = Get.put(UserController());
  HomeController homeController = Get.put(HomeController());
  PaymentController paymentController = Get.put(PaymentController());

  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "Order Summary",
                  size: 18,
                ),
                IconButton(
                    onPressed: () => Get.back(), icon: const Icon(Icons.close))
              ],
            ),
            kHeightBox20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "DELIVERY ADDRESS",
                  color: kGreyDark,
                ),
                CustomText(
                    color: kGreyDark,
                    text: userController.userModel
                        .address![homeController.primaryAddressIndex.value]),
              ],
            ),
            kHeightBox20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "PHONE",
                  color: kGreyDark,
                ),
                CustomText(
                    color: kGreyDark,
                    text: userController.userModel.phoneNumber!),
              ],
            ),
            kHeightBox20,
            Row(
              children: [
                CustomText(
                  text: "TOTAL: ",
                  color: kGreyDark,
                  size: 18,
                ),
                const CustomText(
                  text: "₹250.00",
                  size: 24,
                  weight: FontWeight.bold,
                )
              ],
            ),
            kHeightBox20,
            SizedBox(
                width: double.infinity,
                child: CustomButton(
                    padding: 15,
                    text: CustomText(
                      text: "PROCEED TO PAY",
                      color: kWhite,
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    function: () {
                      paymentController.initiatePayment();
                    },
                    color: kGreen))
          ],
        ),
      ),
    ),
    backgroundColor: kWhite,
  );
}