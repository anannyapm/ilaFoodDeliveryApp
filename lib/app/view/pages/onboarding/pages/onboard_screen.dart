import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ila/app/controller/onboarding_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/auth/pages/otp_auth_page.dart';

import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text.dart';
import '../widgets/dotnavigator.dart';
import '../widgets/onboardingcontent.dart';

class OnBoardingScreenOne extends StatelessWidget {
  OnBoardingScreenOne({super.key});

  final OnboardingController onboardingController =
      Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    onboardingController.pageIndex < 3
                        ? TextButton(
                            child: Text(
                              "Skip",
                              style: TextStyle(
                                  color:Get.isDarkMode?kWhite:  kGreyDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () => onboardingController.skipPage(),
                          )
                        : kHeightBox50
                  ],
                )),
            Expanded(
              flex: 7,
              child: PageView.builder(
                itemCount: onboardList.length,
                itemBuilder: (context, index) {
                  return OnboardingContent(
                      image: onboardList[index].image,
                      title: onboardList[index].title,
                      subtitle: onboardList[index].subtitle);
                },
                controller: onboardingController.pageController,
                onPageChanged: (index) =>
                    onboardingController.setPageIndex(index),
              ),
            ),
            Obx(() => Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          onboardList.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: DotNavigator(
                                  isActive:
                                      index == onboardingController.pageIndex,
                                ),
                              ))
                    ],
                  ),
                )),
            kHeightBox20,
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Obx(() => CustomButton(
                            padding: 15,
                            text: CustomText(
                              text: onboardingController.pageIndex == 3
                          ? "GET STARTED"
                          : "NEXT",
                              color: kWhite,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                            function:() {
                      if (onboardingController.pageIndex == 3) {
                        Get.offAll(() => const OtpAuthPage());
                      } else {
                        onboardingController.updatePageController();
                      }
                    },
                            color: kGreen)
               ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class OnboardData {
  final String image;
  final String title;
  final String subtitle;
  const OnboardData(
      {required this.image, required this.title, required this.subtitle});
}

final onboardList = [
  const OnboardData(
      image: "assets/images/food2.png",
      title: "Meals Made With Love",
      subtitle:
          " Our meals are made with love, using fresh, high-quality ingredients."),
  const OnboardData(
      image: "assets/images/food6.png",
      title: "Yumminess from home",
      subtitle:
          " Find local and homely cuisine near you and get it delivered to home."),
  const OnboardData(
      image: "assets/images/food5.png",
      title: "Faster Food Delivery",
      subtitle:
          " Order food from your favorite restaurants and have it delivered to your door in minutes."),
  const OnboardData(
      image: "assets/images/food3.png",
      title: "Hungry? Order Food Now",
      subtitle:
          " Choose from a variety of cuisines and have your food delivered hot & fresh now."),
];
