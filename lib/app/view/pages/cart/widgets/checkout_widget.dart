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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Price",
                color: kGreyDark,
                weight: FontWeight.w600,
                size: 16,
              ),
              Obx(() => CustomText(
                    text:"₹${cartController.totalItemPrice.value}",
                    color: kBlueShade,
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
                color: kGreyDark,
                weight: FontWeight.w600,
                size: 16,
              ),
              CustomText(
                text:"₹${cartController.applyDiscount.value}",
                weight: FontWeight.w600,
                color: kBlueShade,
                size: 16,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Delivery Charges",
                weight: FontWeight.w600,
                color: kGreyDark,
                size: 16,
              ),
              CustomText(
                text: "₹50.00",
                weight: FontWeight.w600,
                color: kBlueShade,
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
                color: kGreyDark,
                weight: FontWeight.w600,
                size: 18,
              ),
              Obx(() => CustomText(
                    text:"₹${cartController.totalCartPrice.value}",
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
