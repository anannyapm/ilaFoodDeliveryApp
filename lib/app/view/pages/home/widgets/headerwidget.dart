import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/homecontroller.dart';
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
            Row(
              children: [
                Obx(() => CustomText(
                      text: userController.userModel
                          .address![homeController.primaryAddressIndex.value]!,
                      weight: FontWeight.bold,
                      size: 15,
                      color: kBlueShade,
                    )),
                IconButton(
                    onPressed: () => showChangeAddressBottomSheet(),
                    icon: const Icon(
                      Icons.edit_location_alt,
                      size: 18,
                    ))
              ],
            )
          ],
        ),
        IconButton(
            onPressed: () {
              Get.to(() => NotificationPage());
            },
            icon: const Icon(Icons.notifications_outlined))
      ],
    );
  }
}
