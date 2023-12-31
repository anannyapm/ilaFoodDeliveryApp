import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/map_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/close_widget.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../controller/user_controller.dart';
import '../../../shared/widgets/bordered_box.dart';

class AddressPage extends StatelessWidget {
  AddressPage({super.key});

  final UserController userController = Get.put(UserController());
  final HomeController homeController = Get.put(HomeController());
  final MapController mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: userController.getUserAddress,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeightBox20,
                  CloseWidget(
                    actionfunction: () => Get.back(),
                  ),
                  kHeightBox20,
                  CustomText(
                    text: "My Addresses",
                    size: 20,
                    weight: FontWeight.bold,
                    color: kOrange,
                  ),
                  Obx(
                    () => userController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : userController.addressList.isEmpty
                            ? const Center(
                                child: CustomText(text: "No Addresses Found"),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: userController.addressList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: CustomText(
                                        text: userController.addressList[index],
                                        size: 16,
                                        overflow: TextOverflow.ellipsis,
                                        lines: 2,
                                      )),
                                      Row(
                                        children: [
                                          IconButton(
                                              iconSize: 20,
                                              onPressed: () {
                                                mapController.changeEditMode();
                                                mapController.indexSelected =
                                                    index;

                                                log(mapController.isEditMode
                                                    .toString());

                                                mapController.setField(
                                                    userController
                                                        .latlongList[index]
                                                        .latitude,
                                                    userController
                                                        .latlongList[index]
                                                        .longitude,
                                                    userController
                                                        .addressList[index],
                                                    userController
                                                            .completeAddrList[
                                                        index]);

                                                mapController.openMapPage(true);
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              iconSize: 22,
                                              onPressed: () {
                                                if (userController
                                                        .addressList.length ==
                                                    1) {
                                                  showSnackBar(
                                                      "Oops",
                                                      "Atleast one address is mandatory",
                                                      kWarning);
                                                  
                                                }
                                                else{
                                                  Get.dialog(AlertDialog(
                                                  surfaceTintColor:
                                                      Get.isDarkMode
                                                          ? kBlueShade
                                                          : kWhite,
                                                  title: const CustomText(
                                                    text:
                                                        "Do you want to remove this address?",
                                                    size: 16,
                                                    weight: FontWeight.bold,
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          mapController
                                                                  .indexSelected =
                                                              index;
                                                          mapController
                                                              .removeAddress();
                                                          Get.back();
                                                        },
                                                        child: CustomText(
                                                          text: "Yes",
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15,
                                                          color: kWarning,
                                                        )),
                                                    TextButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: CustomText(
                                                          text: "No",
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 15,
                                                          color: Get.isDarkMode
                                                              ? kWhite
                                                              : kBlueShade,
                                                        ))
                                                  ],
                                                ));
                                                }
                                                
                                              },
                                              icon: const Icon(
                                                  Icons.delete_outlined)),
                                        ],
                                      )
                                    ],
                                  );
                                }),
                  ),
                  kHeightBox20,
                  Center(
                    child: BorderedButton(
                      text: CustomText(
                        text: "ADD NEW ADDRESS",
                        color: Get.isDarkMode ? kWhite : kBlueShade,
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                      color: kGreen,
                      function: _getCurrentLoc,
                    ),
                  ),
                  kHeightBox20
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getCurrentLoc() async {
    int status = await mapController.getCurrentLocation();
    if (status == 1) {
      mapController.openMapPage(true);
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
