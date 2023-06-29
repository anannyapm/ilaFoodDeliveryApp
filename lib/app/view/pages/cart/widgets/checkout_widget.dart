import 'package:flutter/material.dart';

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
          const CustomText(
            text: "Price Details",
            size: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Price",
                color: kGreyDark,
                size: 16,
              ),
              CustomText(
                text: "₹250.00",
                color: kGreyDark,
                size: 16,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Discount",
                color: kGreyDark,
                size: 16,
              ),
              CustomText(
                text: "₹50.00",
                color: kGreyDark,
                size: 16,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Delivery Charges",
                color: kGreyDark,
                size: 16,
              ),
              CustomText(
                text: "₹50.00",
                color: kGreyDark,
                size: 16,
              ),
            ],
          ),
          kHeightBox20,
          Row(
            children: [
              const Spacer(),
              CustomText(
                text: "Total: ",
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
                    text: "PLACE ORDER",
                    color: kWhite,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  function: () {
                    return showOrderSummarySheet();
                  },
                  color: kGreen))
        ],
      ),
    );
  }
}

