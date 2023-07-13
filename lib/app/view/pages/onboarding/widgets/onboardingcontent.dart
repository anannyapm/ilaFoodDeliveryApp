import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(image),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
          ),
        ),
        kHeightBox10,
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color:Get.isDarkMode?kWhite:  kGreyDark),
        )
      ],
    );
  }
}