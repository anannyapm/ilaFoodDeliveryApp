import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/settingscontroller.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/customtext.dart';

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
              title: const CustomText(text: 'Account Deletion'),
              subtitle:
                  const CustomText(text: 'Request to delete your account'),
              onTap: () {
                // Handle account deletion request
                _showConfirmationDialog();
              },
            ),
            ListTile(
              title: const CustomText(text: 'Notifications'),
              subtitle:
                  const CustomText(text: 'Enable or disable notifications'),
              trailing: Obx(() => Switch(
                    activeTrackColor: kGreen.withOpacity(0.8),
                        trackOutlineColor: MaterialStatePropertyAll(kWhite),
                    value: settingsController.isNotificationEnabled,
                    onChanged: (value) {
                      settingsController.setNotificationEnabled(value);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        surfaceTintColor: kWhite,
        elevation: 0,
        title:  CustomText(text: 'Account Deletion',weight: FontWeight.bold,color: kWarning,),
        content: const CustomText(
            text: 'Are you sure you want to delete your account?',weight: FontWeight.bold,),
        actions: [
          TextButton(
            onPressed: () {
              // Perform account deletion
          
              
            },
            child:  CustomText(text: 'Delete',color: kWarning,weight: FontWeight.bold,),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const CustomText(text: 'Cancel',weight: FontWeight.bold,),
          ),
        ],
      ),
    );
  }
}
