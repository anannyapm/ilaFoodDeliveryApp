import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/carousel_model.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:lottie/lottie.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCard extends StatelessWidget {
  final CarouselModel carousel;
  const ScratchCard({super.key, required this.carousel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Get.isDarkMode ? kBlueShade : kWhite,
      title: cartController.isCouponApplied.value
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomText(
                    text: "Discount Already Applied!",
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            )
          : const Column(
              children: [
                CustomText(
                  text: "Congrats!",
                  size: 25,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  text: "You have won a scratch card",
                  size: 18,
                ),
              ],
            ),
      content: cartController.isCouponApplied.value
          ? null
          : Obx(
              () => Scratcher(
                //color: Colors.cyan,
                image: Image.asset(
                  'assets/images/scratcher.png',
                  fit: BoxFit.fill,
                ),
                accuracy: ScratchAccuracy.low,
                threshold: 30,
                brushSize: 40,
                onThreshold: () async{
                  cartController.scratchCardOpacity.value = 1;
                  await cartController.fetchAndSelectRandomDiscount(carousel);
                  await cartController
                      .addDiscountToUser(cartController.selectedDiscount.value);
                  await cartController.calculateDiscount();
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: cartController.scratchCardOpacity.value,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: [
                          CustomText(
                            text: cartController.selectedDiscount.value == 0
                                ? "Better Luck Next Time"
                                : "Yay!!You've Won",
                            size: 20,
                          ),
                          cartController.selectedDiscount.value == 0
                              ? Container()
                              : CustomText(
                                  text:
                                      "₹${cartController.selectedDiscount.value}",
                                  size: 22,
                                  weight: FontWeight.bold,
                                ),
                          Expanded(
                              child: cartController.selectedDiscount.value == 0
                                  ? Lottie.asset('assets/animations/smile.json')
                                  : Lottie.asset(
                                      'assets/animations/congrats.json')),
                        ],
                      )),
                ),
              ),
            ),
    );
  }
}
