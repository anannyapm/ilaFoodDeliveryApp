import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ila/app/controller/map_controller.dart';
import 'package:ila/app/utils/constants/constants.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text.dart';

class MapPage extends StatelessWidget {
  final bool isFromProfile;
  final MapController mapController = Get.put(MapController());

  MapPage({super.key, required this.isFromProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        mapController.clearfields();

                        Get.back();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 35,
                      ),
                    ),
                    kWidthBox10,
                    const CustomText(
                      text: "Choose Delivery Location",
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(() => GoogleMap(
                        mapType: MapType.normal,
                        markers: {
                          Marker(
                            markerId: const MarkerId('Current Location'),
                            position:
                                LatLng(mapController.lat, mapController.long),
                          ),
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            mapController.lat,
                            mapController.long,
                          ),
                          zoom: 14,
                        ),
                        onTap: (position) {
                          mapController.latitudeController.value =
                              position.latitude;
                          mapController.longitudeController.value =
                              position.longitude;
                          mapController.getLocationDetails();
                        },
                      )),
                ),
                kHeightBox20,
                Obx(() => Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: kWarning,
                                ),
                                kWidthBox10,
                                Expanded(
                                  child: CustomText(
                                    text: mapController.locationAddress,
                                    weight: FontWeight.bold,
                                    size: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                kHeightBox20,
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: //Obx(() =>
                          CustomButton(
                              padding: 15,
                              text: CustomText(
                                text: !isFromProfile
                                    ? "PROCEED"
                                    : mapController.isEditMode.value
                                        ? "EDIT ADDRESS"
                                        : "ADD COMPLETE LOCATION",
                                color: kWhite,
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                              function: () {
                                if (isFromProfile) {
                                  _getAddAddressSheet();
                                } else {
                                mapController.updateLocation();

                                 // Get.back();
                                }
                              },
                              color: kGreen)
                      //)
                      ),
                ),
                kHeightBox20
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getAddAddressSheet() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: mapController.formKey3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeightBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Enter Your Address",
                      size: 20,
                      weight: FontWeight.bold,
                      color: kOrange,
                    ),
                    IconButton(
                        onPressed: () {
                         
                          Get.back();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                Obx(() => Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: kWarning,
                              ),
                              kWidthBox10,
                              Expanded(
                                child: CustomText(
                                  text: mapController.locationAddress,
                                  weight: FontWeight.bold,
                                  size: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                TextFormField(
                  minLines: 1,
                  maxLines: 3,
                  controller: mapController.addressController,
                  validator: (value) => mapController.validateAddress(value),
                  decoration: const InputDecoration(
                    labelText: "Complete Address",
                  ),
                ),
                kHeightBox20,
                kHeightBox10,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                        text: CustomText(
                          text: "Save Address",
                          color: kWhite,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                        function: () async {
                          await mapController.onSaveAddress();
                          //Get.back();
                        },
                        color: kGreen,
                        padding: 0))
              ],
            ),
          ),
        ),
      ),
      backgroundColor:Get.isDarkMode?kBlueShade: kWhite,
    );
  }
}
