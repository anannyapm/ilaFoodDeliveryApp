import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/navigationcontroller.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/pages/profile/faq_page.dart';
import 'package:ila/app/view/pages/profile/settings_page.dart';
import 'package:ila/app/view/pages/profile/widgets/address_sheet.dart';
import 'package:ila/app/view/pages/profile/widgets/profile_view_more_sheet.dart';
import 'package:ila/app/view/pages/profile/widgets/user_edit_sheet.dart';
import 'package:ionicons/ionicons.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/custom_text.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final AuthController authController = Get.put(AuthController());
  final NavigationController navigationController =
      Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
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
                        CustomText(
                          text: authController.userModel.name!,
                          weight: FontWeight.bold,
                          size: 22,
                        ),
                        CustomText(
                          text: authController.userModel.phoneNumber!,
                          size: 18,
                          color: kGreylight,
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () => Get.bottomSheet(UserEditSheet(),
                            backgroundColor: kWhite),
                        child: CustomText(
                          text: "Edit",
                          color: kOrange,
                          weight: FontWeight.bold,
                          size: 16,
                        ))
                  ],
                ),
                kHeightBox20,
                ProfileViewMoreWidget(
                    text: "Addresses",
                    icon: Ionicons.map_outline,
                    function: () => Get.bottomSheet(AddressSheet(),
                        backgroundColor: kWhite),
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
                    function: () => Get.to(const FaqPage()),
                    color: kOrange),
                ProfileViewMoreWidget(
                    text: "Settings",
                    icon: Ionicons.settings_outline,
                    function: () => Get.to(const SettingsPage()),
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
                        surfaceTintColor: kWhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        titleTextStyle:
                            TextStyle(fontSize: 22, color: kBlueShade),
                        title: const CustomText(
                          text: "Are you sure you want to sign out?",
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Get.back(),
                              child: CustomText(
                                text: "No",
                                color: kGreen,
                                size: 20,
                                weight: FontWeight.bold,
                              )),
                          TextButton(
                              onPressed: () => authController.logout(),
                              child: CustomText(
                                text: "Yes",
                                color: kWarning,
                                size: 20,
                                weight: FontWeight.bold,
                              )),
                        ],
                      ));
                    },
                    color: kWarning),
                kHeightBox50,
                const Center(
                  child: CustomText(
                    text: "App Version 1.0.0",
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
