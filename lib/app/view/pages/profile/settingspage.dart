import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/customtext.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isNotificationEnabled = true;

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
              title: const CustomText(text:'Account Deletion'),
              subtitle: const CustomText(text: 'Request to delete your account'),
              onTap: () {
                // Handle account deletion request
                _showConfirmationDialog();
              },
            ),
            ListTile(
              title: const CustomText(text: 'Notifications'),
              subtitle: const CustomText(text: 'Enable or disable notifications'),
              trailing: Switch(
                value: _isNotificationEnabled,
                onChanged: (value) {
                  setState(() {
                    _isNotificationEnabled = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const CustomText(text:'Account Deletion'),
          content: const CustomText(text:'Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform account deletion
                Navigator.of(context).pop();
                _showDeletionConfirmationSnackbar();
              },
              child: const CustomText(text:'Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const CustomText(text: 'Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDeletionConfirmationSnackbar() {
    final snackBar = const SnackBar(
      content: Text('Account deleted successfully'),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
