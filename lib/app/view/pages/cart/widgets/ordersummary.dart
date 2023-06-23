import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/cart/widgets/paymentoption.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

import '../../../shared/widgets/custombutton.dart';

void showOrderSummarySheet() {
  AuthController authController = Get.put(AuthController());
  LoginController loginController = Get.put(LoginController());

  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Order Summary",
              size: 18,
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
                    text: authController.userModel
                        .address![loginController.primaryAddressIndex.value]),
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
                CustomText(color: kGreyDark,text: authController.userModel.phoneNumber!),
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
                        child:CustomButton(
                            padding: 15,
                            text: CustomText(
                              text: "CONTINUE",
                              color: kWhite,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                            function: () {
                              return showPaymentOptionSheet();
                            },
                            color: kGreen)
                       
                      )
          ],
        ),
      ),
    ),
    backgroundColor: kWhite,
  );
}
