import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/cart/widgets/successpage.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../../controller/cart_controller.dart';
import '../../../shared/widgets/custom_button.dart';

void showPaymentOptionSheet() {
  CartController cartController = Get.put(CartController());

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
                  text: "Choose Payment Option",
                  size: 18,
                ),
                TextButton(onPressed:()=> Get.back(), child:  CustomText(text: "Back",size: 15,color: kBlueShade,))

              ],
            ),
            kHeightBox20,
            Column(
              children: [
                for (var option in cartController.options)
                  Obx(() => RadioListTile<String>(
                        
                        title: Text(option),
                        value: option,
                        groupValue: cartController.selectedOption.value,
                        onChanged: (value) {
                          cartController.setSelectedOption(value!);
                        },
                      ))
              ],
            ),
            kHeightBox20,
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                  padding: 15,
                  text: CustomText(
                    text: "CONTINUE",
                    color: kWhite,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  function: () => Get.offAll(() => const SuccessPage()),
                  color: kGreen),
            )
          ],
        ),
      ),
    ),
    backgroundColor: kWhite,
  );
}
