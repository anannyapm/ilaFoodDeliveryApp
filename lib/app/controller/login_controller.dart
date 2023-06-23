import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  RxBool isLogButtonEnabled = false.obs;
  RxBool isButtonEnabled = false.obs;
  TextEditingController otpCode = TextEditingController();
  //RxString otpCode = "".obs;
  GeoPoint location = const GeoPoint(0, 0);
  String address = "";

  RxInt primaryAddressIndex = 0.obs;

  String get name => nameController.text.trim();
  String get email => emailController.text.trim();
  @override
  void onInit() {
    super.onInit();

    textEditingController.addListener(checkField);
    emailController.addListener(checkRegField);
    nameController.addListener(checkRegField);
  }

  void checkField() {
    if (textEditingController.text.trim().isNotEmpty &&
        formKey1.currentState!.validate()) {
      isLogButtonEnabled.value = true;
    } else {
      isLogButtonEnabled.value = false;
    }
  }

  void checkRegField() {
    if (nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        formKey2.currentState!.validate()) {
      isButtonEnabled.value = true;
    } else {
      isButtonEnabled.value = false;
    }
  }

  final List<String> countryCodes = [
    '+91',
    '+1',
    '+44',
    '+61',
    '+86',
    '+81',
    '+39',
    '+33',
    '+49'
  ];

  final List<String> countryNames = [
    'India',
    'USA',
    'UK',
    'Australia',
    'China',
    'Japan',
    'Italy',
    'France',
    'Germany'
  ];

  final TextEditingController searchController = TextEditingController();
  final RxString _selectedCode = '+91'.obs;

  String get selectedCode => _selectedCode.value;

//unused i guess
  List<String> get filteredCountryCodes {
    final searchQuery = searchController.text.trim().toLowerCase();
    if (searchQuery.isEmpty) {
      return countryCodes;
    } else {
      return countryCodes
          .where((code) => code.toLowerCase().contains(searchQuery))
          .toList();
    }
  }

  setSelectedCountry(String code) {
    _selectedCode.value = code;
  }

  String getCountryName(String code) {
    final index = countryCodes.indexOf(code);
    if (index != -1) {
      return countryNames[index];
    }
    return '';
  }

  @override
  void onClose() {
    textEditingController.dispose();

    super.onClose();
  }
}
