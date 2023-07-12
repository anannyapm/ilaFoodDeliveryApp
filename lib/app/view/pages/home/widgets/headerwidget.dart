import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/cart/widgets/changeaddress.dart';
import 'package:ila/app/view/pages/home/pages/notificationpage.dart';

import '../../../../controller/user_controller.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/custom_text.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    super.key,
    required this.userController,
  });

  final UserController userController;
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Delivery To",
              color: kOrange,
              weight: FontWeight.bold,
              size: 14,
            ),
            kHeightBox10,
           Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
             onTap: () => showChangeAddressBottomSheet(),
             child: const Icon(
               Icons.edit_location_alt,
               size: 18,
             )),
             kWidthBox10,
                Obx(() => SizedBox(
           width: MediaQuery.of(context).size.width*0.6,

           child: CustomText(
                   text: userController.userModel
                       .address![homeController.primaryAddressIndex.value]!,
                   weight: FontWeight.bold,
                   size: 15,
                   color:Get.isDarkMode?kWhite: kBlueShade,
                   overflow:TextOverflow.ellipsis,
                 ),
                ),
                ),
                
              ],
            )
          ],
        ),
        IconButton(
            onPressed: () {
              Get.to(() => const NotificationPage());
            },
            icon: const Icon(Icons.notifications_outlined))
      ],
    );
  }
}
