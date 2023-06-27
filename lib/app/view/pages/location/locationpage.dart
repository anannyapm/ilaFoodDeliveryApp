import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/controller/mapcontroller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/constants/color_constants.dart';

class LocationPage extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());
  LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/map.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
                kHeightBox60,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                      onPressed: () async {
                        int status = await mapController.getCurrentLocation();
                        if (status == 1) {
                          Get.dialog(Obx(() => authController.isUserAdding.value?const Center(child: CircularProgressIndicator()): AlertDialog(
                                alignment: Alignment.center,
                                surfaceTintColor: kWhite,
                                title: const Text(
                                  'Location Accessed',
                                  textAlign: TextAlign.center,
                                ),
                                content: Obx(() => CustomText(
                                      text:
                                          'Current Location is \n ${mapController.locationAddress}',
                                      align: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await authController.addUserToFirebase();
                                      Get.offAll(() => NavigationPage());
                                      //add data to db
                                      //open home page
                                    },
                                    child: const CustomText(
                                      text: 'Proceed',
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      mapController.openMapPage();
                                    },
                                    child: const Text('Edit Location'),
                                  ),
                                ],
                              )));
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
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          surfaceTintColor: kGreen,
                          backgroundColor: kGreen,
                          padding: const EdgeInsets.all(15),
                          elevation: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "ACCESS LOCATION",
                            style: TextStyle(
                                color: kWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          CircleAvatar(
                              backgroundColor: kWhite.withOpacity(0.4),
                              child: Icon(
                                Icons.location_pin,
                                color: kWhite,
                              ))
                        ],
                      )),
                ),
                kHeightBox20,
                CustomText(
                  text:
                      'ILA WILL ACCESS YOUR LOCATION ONLY WHILE USING THE APP',
                  align: TextAlign.center,
                  color: kGreyDark,
                )
                /*  const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    mapController.openMapPage();
                  },
                  child: const Text('Open Map'),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
