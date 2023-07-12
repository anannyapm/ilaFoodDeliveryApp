import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/payment_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
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
                  color:Get.isDarkMode?kWhite: kGreyDark,
                ),
                CustomText(
                    color:Get.isDarkMode?kWhite: kGreyDark,
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
                  color:Get.isDarkMode?kWhite: kGreyDark,
                ),
                CustomText(
                    color:Get.isDarkMode?kWhite: kGreyDark,
                    text: userController.userModel.phoneNumber!),
              ],
            ),
            kHeightBox20,
            Row(
              children: [
                CustomText(
                  text: "TOTAL: ",
                  color:Get.isDarkMode?kWhite: kGreyDark,
                  size: 18,
                ),
                CustomText(
                  text: cartController.totalCartPrice.toString(),
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
                      paymentController.initiatePayment(
                          amount: (cartController.totalCartPrice * 100).toInt(),
                          name: userController.userModel.name!,
                          phoneNumber: userController.userModel.phoneNumber,
                          );
                    },
                    color: kGreen))
          ],
        ),
      ),
    ),
    backgroundColor:Get.isDarkMode?kGreyDark: kWhite,
  );
}
