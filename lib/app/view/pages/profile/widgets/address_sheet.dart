import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/homecontroller.dart';
import 'package:ila/app/controller/mapcontroller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/custom_textformfield.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shared/widgets/bordered_box.dart';

class AddressSheet extends StatelessWidget {
  AddressSheet({super.key});

  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeightBox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "My Addresses",
                  size: 20,
                  weight: FontWeight.bold,
                  color: kOrange,
                ),
                IconButton(
                    onPressed: () => Get.back(), icon: const Icon(Icons.close))
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: authController.userModel.address!.length,
                itemBuilder: (context, index) {
                  /*  TextEditingController addressController =
                      TextEditingController(
                          text: authController.userModel.address![index]!); */
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Obx(() => CustomText(
                              text: authController.userModel.address![index]!,
                              size: 16,
                              overflow: TextOverflow.ellipsis,
                              lines: 2,
                            )),
                      ),
                      Row(
                        children: [
                          IconButton(
                              iconSize: 20,
                              onPressed: () {
                                mapController.changeEditMode();
                                //handle submiting data to db when done pressed
                                log(mapController.isEditMode.toString());

                                mapController.setField(
                                    authController
                                        .userModel.location![index].latitude,
                                    authController
                                        .userModel.location![index].longitude,
                                    authController.userModel.address![index]!);
                                mapController.openMapPage();
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              iconSize: 22,
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outlined)),
                        ],
                      )
                    ],
                  );
                }),
            kHeightBox20,
            Center(
              child: BorderedButton(
                text: CustomText(
                  text: "ADD NEW ADDRESS",
                  color: kBlueShade,
                  size: 14,
                  weight: FontWeight.bold,
                ),
                color: kGreen,
                function: _getCurrentLoc,

                //should open page for selecting map location
              ),
            ),
            kHeightBox20
          ],
        ),
      ),
    );
  }

  void _getCurrentLoc() async {
    int status = await mapController.getCurrentLocation();
    if (status == 1) {
      mapController.openMapPage();
    }
    if (status == 2) {
      Get.dialog(
        AlertDialog(
          title: const Text('Location Permission'),
          content: const Text(
              'Please grant permission to access the device\'s location.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }
    if (status == 3) {
      Get.dialog(
        AlertDialog(
          title: const Text('Location Permission'),
          content: const Text(
              'Please grant permission to access the device\'s location.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    }
  }
}
