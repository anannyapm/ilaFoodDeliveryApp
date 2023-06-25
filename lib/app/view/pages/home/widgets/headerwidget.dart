import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/view/pages/home/pages/notificationpage.dart';

import '../../../../controller/auth_controller.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/customtext.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    super.key,
    required this.authController,
  });

  final AuthController authController;
  final LoginController loginController = Get.put(LoginController());

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
            CustomText(
              text: authController.userModel
                  .address![loginController.primaryAddressIndex.value]!,
              weight: FontWeight.bold,
              size: 15,
              color: kBlueShade,
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
