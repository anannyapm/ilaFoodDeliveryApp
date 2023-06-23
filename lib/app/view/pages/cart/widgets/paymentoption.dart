import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/cart/widgets/successpage.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

import '../../../../controller/cartcontroller.dart';
import '../../../shared/widgets/custombutton.dart';

void showPaymentOptionSheet() {
  CartController cartController = Get.put(CartController());
  LoginController loginController = Get.put(LoginController());

  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Choose Payment Option",
              size: 18,
            ),
            kHeightBox20,
           Column(
                  children: [
                    for (var option in cartController.options)
                       Obx(() => RadioListTile<String>(
                                                   //toggleable: true,
                                                   //selected: controller.selectedOption.value==controller.options.indexOf(option),
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
              child:CustomButton(
                            padding: 15,
                            text: CustomText(
                              text: "CONTINUE",
                              color: kWhite,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                            function: () =>Get.offAll(()=>SuccessPage()),
                            color: kGreen),
             
            )
          ],
        ),
      ),
    ),
    backgroundColor: kWhite,
  );
}
