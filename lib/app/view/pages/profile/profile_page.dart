import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/navigation_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/utils/constants/app_detail.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/pages/profile/faq_page.dart';
import 'package:ila/app/view/pages/profile/settings_page.dart';
import 'package:ila/app/view/pages/profile/widgets/address_page.dart';
import 'package:ila/app/view/pages/profile/widgets/profile_view_more_sheet.dart';
import 'package:ila/app/view/pages/profile/widgets/user_edit_sheet.dart';
import 'package:ionicons/ionicons.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/custom_text.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final UserController userController = Get.put(UserController());
  final AuthController authController = Get.put(AuthController());
  final NavigationController navigationController =
      Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeightBox20,
              const CustomText(
                text: "My Account",
                size: 24,
              ),
              kHeightBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => CustomText(
                            text: userController.userModel.name??"User",
                            weight: FontWeight.bold,
                            size: 22,
                          )),
                      CustomText(
                        text: userController.userModel.phoneNumber!,
                        size: 18,
                        color: kGreylight,
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () => Get.bottomSheet(UserEditSheet(),
                          backgroundColor:Get.isDarkMode?kBlueShade: kWhite),
                      child: CustomText(
                        text: "Edit",
                        color: kOrange,
                        weight: FontWeight.bold,
                        size: 16,
                      ))
                ],
              ),
              kHeightBox10,
              Row(
                children: [
                  const CustomText(
                    text: "Discount Balance ",
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  kWidthBox15,
                  Obx(() => CustomText(
                        text: "₹ ${userController.userModel.discounts}",
                        color: kGreen,
                        weight: FontWeight.bold,
                        size: 18,
                      )),
                ],
              ),
              kHeightBox20,
              ProfileViewMoreWidget(
                  text: "Addresses",
                  icon: Ionicons.map_outline,
                  function: () => Get.to(() => AddressPage()),
                  color: kIconBlue),
              ProfileViewMoreWidget(
                  text: "Cart",
                  icon: Ionicons.bag_handle_outline,
                  function: () {
                    navigationController.setSelectedIndex(4);
                    Get.to(() => NavigationPage());
                  },
                  color: kIconLightBlue),
              ProfileViewMoreWidget(
                  text: "Favorites",
                  icon: Ionicons.heart_outline,
                  function: () {
                    navigationController.setSelectedIndex(1);
                    Get.to(() => NavigationPage());
                  },
                  color: kIconViolet),
              ProfileViewMoreWidget(
                  text: "FAQs",
                  icon: Ionicons.help_circle_outline,
                  function: () => Get.to(() => const FaqPage()),
                  color: kOrange),
              ProfileViewMoreWidget(
                  text: "Settings",
                  icon: Ionicons.settings_outline,
                  function: () => Get.to(() => const SettingsPage()),
                  color: kIconBlue),
              ProfileViewMoreWidget(
                  text: "Review App",
                  icon: Ionicons.star_outline,
                  function: () {},
                  color: kIconOceanBlue),
              ProfileViewMoreWidget(
                  text: "Share App",
                  icon: Ionicons.share_social,
                  function: () {},
                  color: kGreen),
              ProfileViewMoreWidget(
                  text: "Logout",
                  icon: Ionicons.log_out_outline,
                  function: () {
                    Get.dialog(AlertDialog(
                      surfaceTintColor:Get.isDarkMode?kBlueShade: kWhite,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      titleTextStyle: TextStyle(
                          fontSize: 18,
                          color:Get.isDarkMode?kWhite: kBlueShade,
                          fontWeight: FontWeight.bold),
                      title: const CustomText(
                        text: "Are you sure you want to Sign Out?",
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Get.back(),
                            child: CustomText(
                              text: "No",
                              color: kGreen,
                              size: 16,
                              weight: FontWeight.bold,
                            )),
                        TextButton(
                            onPressed: () => authController.logout(),
                            child: CustomText(
                              text: "Yes",
                              color: kWarning,
                              size: 16,
                              weight: FontWeight.bold,
                            )),
                      ],
                    ));
                  },
                  color: kWarning),
                ],
              ),
             
               Center(
                child: CustomText(
                  text: "App Version ${AppDetails.appVersion}",
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
