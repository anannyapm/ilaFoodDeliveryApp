import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/navigationcontroller.dart';
import 'package:ila/app/view/pages/cart/cartpage.dart';
import 'package:ila/app/view/pages/favourite/favouritepage.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/pages/profile/faqpage.dart';
import 'package:ila/app/view/pages/profile/settingspage.dart';
import 'package:ila/app/view/pages/profile/widgets/addressssheet.dart';
import 'package:ila/app/view/pages/profile/widgets/profileviewmore.dart';
import 'package:ila/app/view/pages/profile/widgets/usereditsheet.dart';
import 'package:ionicons/ionicons.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/customtext.dart';

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
              children: [
                kHeightBox10,
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              kGreylight.withOpacity(0.4))),
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 30,
                      ),
                    ),
                    kWidthBox15,
                    const CustomText(
                      text: "My Account",
                      size: 20,
                    )
                  ],
                ),
                kHeightBox50,
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
                      Get.to(()=>NavigationPage());
                    },
                    color: kIconLightBlue),
                ProfileViewMoreWidget(
                    text: "Favorites",
                    icon: Ionicons.heart_outline,
                    function: () {
                      navigationController.setSelectedIndex(1);
                      Get.to(()=>NavigationPage());
                    },
                    color: kIconViolet),
                ProfileViewMoreWidget(
                    text: "FAQs",
                    icon: Ionicons.help_circle_outline,
                    function: () => Get.to(FaqPage()),
                    color: kOrange),
                ProfileViewMoreWidget(
                    text: "Settings",
                    icon: Ionicons.settings_outline,
                    function: () => Get.to(SettingsPage()),
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
                const CustomText(
                  text: "App Version 1.0.0",
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
