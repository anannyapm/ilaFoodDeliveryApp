import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view/pages/location/widget/mapwidget.dart';

class MapController extends GetxController {
  TextEditingController addressController = TextEditingController();
  final formKey3 = GlobalKey<FormState>();

  RxDouble latitudeController = 0.0.obs;
  RxDouble longitudeController = 0.0.obs;
  final RxString _locationAddress = "".obs;

  String get locationAddress => _locationAddress.value;

  double get lat => latitudeController.value;
  double get long => longitudeController.value;

  RxBool isEditMode = true.obs;

  void changeEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  void setField(double lat, double long, String address) {
    latitudeController.value = lat;
    longitudeController.value = long;
    _locationAddress.value = address;
    addressController.text = locationAddress;
  }

  void clearfields() {
    addressController.clear();
    _locationAddress.value = "";
    latitudeController.value = 0;
    longitudeController.value = 0;
  }

  validateAddress(value) {
    if (value.trim().isEmpty) {
      return "Address cannot be empty";
    } else {
      return null;
    }
  }

  onSaveAddress() {
    if (formKey3.currentState!.validate()) {
      _locationAddress.value =
          "${addressController.text.trim()},$locationAddress";
      log(locationAddress);
      Get.back();
    } else {
      return null;
    }
  }

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

        _locationAddress.value = '$address, $city';
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
