import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ila/app/controller/mapcontroller.dart';
import 'package:ila/app/utils/constants/constants.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/custombutton.dart';
import '../../../shared/widgets/customtext.dart';

class MapPage extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Expanded(
                  child: GoogleMap(
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
                  ),
                ),
                kHeightBox20,
                Obx(() => Column(
                      children: [
                        Text(mapController.location),
                       /*  Text(
                            mapController.longitudeController.value.toString()) */
                      ],
                    )),
                kHeightBox20,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomButton(
                            padding: 15,
                            text: CustomText(
                              text: "UPDATE LOCATION",
                              color: kWhite,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                            function:() {
                        mapController.updateLocation();
                      },
                            color: kGreen)
                  
                  
                ),
                kHeightBox20
              ],
            ),
          ),
        ),
      ),
    );
  }
}
