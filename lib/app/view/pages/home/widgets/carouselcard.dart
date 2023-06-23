import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/homecontroller.dart';

import '../../../../utils/constants/color_constants.dart';

class CarouselCard extends StatelessWidget {
   CarouselCard({
    super.key,
  });
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kGrey.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes the shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          image:  DecorationImage(
            image: NetworkImage(
                homeController.carousels[0].imageUrl!),
            fit: BoxFit.cover,
          )),
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 5),
    );
  }
}
