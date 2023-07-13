import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/navigation_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../shared/widgets/custom_button.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/success.png"))),
                  ),
                  const CustomText(
                    text: "Order Placed !",
                    size: 25,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text:
                        "Keep Your Plates Ready!\nYour order shall be delivered soon.",
                    size: 18,
                    color:Get.isDarkMode?kGreylight: kGreyDark,
                    align: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                    padding: 15,
                    text: CustomText(
                      text: "DONE",
                      color: kWhite,
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    function: () {
                      navigationController.setSelectedIndex(3);
                      Get.offAll(() => NavigationPage());
                    },
                    color: kGreen),
              ),
              kHeightBox10
            ],
          ),
        ),
      )),
    );
  }
}
