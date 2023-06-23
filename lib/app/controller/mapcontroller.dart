import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view/pages/location/widget/mapwidget.dart';

class MapController extends GetxController {
  RxDouble latitudeController = 0.0.obs;
  RxDouble longitudeController = 0.0.obs;
  final RxString _location = "".obs;

  String get location => _location.value;

  double get lat => latitudeController.value;
  double get long => longitudeController.value;

  //status 1 = success, status 2= error,denied, 3 =>error, permanently denied
  Future<int> getCurrentLocation() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitudeController.value = position.latitude;
      longitudeController.value = position.longitude;
      await getLocationDetails();
      return 1;
    } else if (status.isDenied) {
      return 2;
      // Handle the case where the user denied the permission
    } else if (status.isPermanentlyDenied) {
      return 3;
      // Handle the case where the user permanently denied the permission
    }
    return 0;
  }

  Future<void> getLocationDetails() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latitudeController.value, longitudeController.value);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = placemark.street!;
        String city = placemark.locality!;

        _location.value = '$address, $city';
      }
    } catch (e) {
      log('Error fetching location details: $e');
    }
  }

  void openMapPage() {
    Get.to(() => MapPage());
  }

  void updateLocation() async {
    await getLocationDetails();
    Get.back();
  }
}
