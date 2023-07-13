import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:ila/app/view/pages/home/widgets/scratch_card.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/controllers.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    
    int index=math.Random().nextInt(homeController.carousels.length);

    return GestureDetector(
      onTap: () {
       homeController.carousels.isNotEmpty? Get.dialog(ScratchCard(carousel:homeController.carousels[index] ,)):null;
      },
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
         
          boxShadow: [
            BoxShadow(
              color:Get.isDarkMode?kWhite.withOpacity(0.1): kGrey.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes the shadow position
            ),
          ],
        ),
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 5),
        child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child:homeController.carousels.isEmpty? const Image(image: AssetImage('assets/images/ilabanner.png')) : FadeInImage(
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: const AssetImage('assets/images/placeholder.jpg'),
      image:NetworkImage(homeController.carousels[index].imageUrl!,),
      imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/placeholder.jpg',fit: BoxFit.cover,) ,
      fit: BoxFit.cover,
    ),
      ),
    ));
  }
}
