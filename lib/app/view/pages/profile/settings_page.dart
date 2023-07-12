import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/settings_controller.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/custom_text.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
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
                  text: "Settings",
                  size: 20,
                )
              ],
            ),
            kHeightBox10,
            ListTile(
              title: const CustomText(text: 'Notifications'),
              subtitle:
                  const CustomText(text: 'Enable or disable notifications'),
              trailing: Obx(() => Switch(
                    activeTrackColor: kGreen.withOpacity(0.8),
                    trackOutlineColor: MaterialStatePropertyAll(
                        Get.isDarkMode ? kGrey : kWhite),
                    value: settingsController.isNotificationEnabled,
                    onChanged: (value) {
                      settingsController.updateNotificationStatus(value);
                    },
                  )),
            ),
            ListTile(
              title: const CustomText(text: 'Theme'),
              subtitle: const CustomText(text: 'Change Dark/Light Theme'),
              trailing: Obx(() => Switch(
                    activeTrackColor: kGreen.withOpacity(0.8),
                    trackOutlineColor: MaterialStatePropertyAll(
                        Get.isDarkMode ? kGrey : kWhite),
                    value: settingsController.isDarkMode.value,
                    onChanged: (value) {
                      Get.changeTheme(
                          Get.isDarkMode ? ThemeData.light() : ThemeData());
                      settingsController.toggleTheme();
                      log(Get.isDarkMode.toString() +
                          settingsController.isDarkMode.value.toString());
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
