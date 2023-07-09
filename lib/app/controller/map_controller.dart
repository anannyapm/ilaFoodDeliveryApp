import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/usermodel.dart';
import '../services/firebase_services.dart';
import '../view/pages/location/widget/map_widget.dart';

class MapController extends GetxController {
  // UserController userController = Get.put(UserController());
  TextEditingController addressController = TextEditingController();
  final formKey3 = GlobalKey<FormState>();

  RxDouble latitudeController = 0.0.obs;
  RxDouble longitudeController = 0.0.obs;
  final RxString _completeAddress = "".obs;

  final RxString _locationAddress = "".obs;

  RxList completeAddrList = [].obs;
  RxList locationList = [].obs;
  RxList deliveryAddrList = [].obs;

  String get locationAddress => _locationAddress.value;
  String get completeAddress => _completeAddress.value;

  double get lat => latitudeController.value;
  double get long => longitudeController.value;

  RxBool isEditMode = false.obs;
  RxBool isLoading = false.obs;

  int indexSelected = 0;

  @override
  void onInit() async {
    userCollectionRef = firebaseFirestore.collection("users");

    super.onInit();
  }

  @override
  void dispose() {
    userController.dispose();
    addressController.dispose();

    super.dispose();
  }

  void changeEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  void setField(
      double lat, double long, String location, String completeaddress) {
    latitudeController.value = lat;
    longitudeController.value = long;
    _locationAddress.value = location;
    addressController.text = completeaddress;
  }

  void clearfields() {
    addressController.clear();
    _locationAddress.value = "";
    _completeAddress.value = "";
    latitudeController.value = 0;
    longitudeController.value = 0;
    isEditMode.value = false;
  }

  validateAddress(value) {
    if (value.trim().isEmpty) {
      return "Address cannot be empty";
    } else {
      return null;
    }
  }

  Future onSaveAddress() async {
    if (formKey3.currentState!.validate()) {
      _completeAddress.value = addressController.text.trim();

      if (isEditMode.value == true) {
        isEditMode.value = false;
        await updateAddress();
        await userController.setUser(UserModel.fromSnapshot(
            await userCollectionRef
                .doc(userController.userModel.userId)
                .get()));
        Get.back();
        Get.back();

        //Get.off(()=>AddressPage());
        showSnackBar("Done", "Update Success", kGreen);
      } else {
        await addNewAddress();
        await userController.setUser(UserModel.fromSnapshot(
            await userCollectionRef
                .doc(userController.userModel.userId)
                .get()));

        Get.back();

        showSnackBar("Done", "Added", kGreen);
      }

      //Get.off(ProfilePage());
    } else {
      return null;
    }
  }


  Future<void> updateAddress() async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    firebaseFirestore.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(userDocRef);

      if (snapshot.exists) {
        log(userController.addressList.toString());
        log(userController.latlongList.toString());
        log(userController.completeAddrList.toString());

        userController.addressList[indexSelected] = locationAddress;
        userController.userModel.address![indexSelected] = locationAddress;

        transaction.update(
            userDocRef, {"deliveryAddress": userController.addressList});

        userController.latlongList[indexSelected] = GeoPoint(lat, long);
        userController.userModel.location![indexSelected] = GeoPoint(lat, long);

        transaction
            .update(userDocRef, {"location": userController.latlongList});

        userController.completeAddrList[indexSelected] = completeAddress;
        userController.userModel.completeAddress![indexSelected] =
            completeAddress;

        transaction.update(
            userDocRef, {"completeAddress": userController.completeAddrList});
     
      }
    });
  }

  Future<void> addNewAddress() async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    firebaseFirestore.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(userDocRef);

      if (snapshot.exists) {
        List<dynamic> list =
            List<dynamic>.from(snapshot.get('deliveryAddress'));
        list.add(locationAddress);

        transaction.update(userDocRef, {"deliveryAddress": list});

        List<dynamic> locList = List<dynamic>.from(snapshot.get('location'));
        locList.add(GeoPoint(lat, long));

        transaction.update(userDocRef, {"location": locList});

        List<dynamic> compAddress =
            List<dynamic>.from(snapshot.get('completeAddress'));
        compAddress.add(completeAddress);

        transaction.update(userDocRef, {"completeAddress": compAddress});
        userController.userModel.address!.add(locationAddress);
        userController.userModel.location!.add(GeoPoint(lat, long));
        userController.userModel.completeAddress!.add(completeAddress);
        // userController.getUserAddress();
      }
    });
  }

  Future<void> removeAddress() async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    firebaseFirestore.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(userDocRef);

      if (snapshot.exists) {
        List<dynamic> list =
            List<dynamic>.from(snapshot.get('deliveryAddress'));
        list.removeAt(indexSelected);

        transaction.update(userDocRef, {"deliveryAddress": list});

        List<dynamic> locList = List<dynamic>.from(snapshot.get('location'));
        locList.removeAt(indexSelected);

        transaction.update(userDocRef, {"location": locList});

        List<dynamic> completeAddrList =
            List<dynamic>.from(snapshot.get('completeAddress'));
        completeAddrList.removeAt(indexSelected);

        transaction.update(userDocRef, {"completeAddress": completeAddrList});
        userController.userModel.address!.remove(locationAddress);
        userController.userModel.location!.remove(GeoPoint(lat, long));
        userController.userModel.completeAddress!.remove(completeAddress);
        userController.getUserAddress();
      }
    });
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

  void openMapPage(bool isfromprofile) {
    Get.to(() => MapPage(
          isFromProfile: isfromprofile,
        ));
  }

  void updateLocation() async {
    await getLocationDetails();
    Get.back();
  }
}
