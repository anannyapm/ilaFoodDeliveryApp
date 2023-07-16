import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/controllers.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text.dart';
import 'ordersummary.dart';

class CheckoutDetailWidget extends StatelessWidget {
  const CheckoutDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => cartController.discountValue.value == 0
              ? Container()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        cartController.applyDiscount.value == 0
                            ? cartController.applyDiscountValue()
                            : cartController.removeDiscountValue();
                        cartController.getTotalPrice();
                      },
                      child: Obx(() => CustomText(
                            text: cartController.applyDiscount.value == 0
                                ? "Apply Discount"
                                : "Remove Discount",
                            color: cartController.applyDiscount.value == 0
                                ? kGreen
                                : kWarning,
                            weight: FontWeight.bold,
                          ))),
                )),
          kHeightBox10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Price",
                color: Get.isDarkMode ? kWhite : kGreyDark,
                weight: FontWeight.w600,
                size: 16,
              ),
              Obx(() => CustomText(
                    text: "₹${cartController.totalItemPrice.value.toInt()}",
                    color: Get.isDarkMode ? kWhite : kBlueShade,
                    weight: FontWeight.w600,
                    size: 16,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Discount",
                color: Get.isDarkMode ? kWhite : kGreyDark,
                weight: FontWeight.w600,
                size: 16,
              ),
              Obx(() => CustomText(
                    text: "-₹${cartController.applyDiscount.value}",
                    weight: FontWeight.w600,
                    color: Get.isDarkMode ? kWhite : kBlueShade,
                    size: 16,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Delivery Charges",
                weight: FontWeight.w600,
                color: Get.isDarkMode ? kWhite : kGreyDark,
                size: 16,
              ),
              CustomText(
                text: "₹${cartController.deliveryCharge}",
                weight: FontWeight.w600,
                color: Get.isDarkMode ? kWhite : kBlueShade,
                size: 16,
              ),
            ],
          ),
          kHeightBox20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Total: ",
                color: Get.isDarkMode ? kWhite : kGreyDark,
                weight: FontWeight.w600,
                size: 18,
              ),
              Obx(() => CustomText(
                    text: "₹${cartController.totalCartPrice.value.toInt()}",
                    size: 22,
                    weight: FontWeight.bold,
                  ))
            ],
          ),
          kHeightBox20,
          SizedBox(
              width: double.infinity,
              child: CustomButton(
                  padding: 15,
                  text: CustomText(
                    text: "PLACE ORDER",
                    color: kWhite,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  function: () {
                    return showOrderSummarySheet();
                  },
                  color: kOrange))
        ],
      ),
    );
  }
}
