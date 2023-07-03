import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/color_constants.dart';

showSnackBar(String title,String subtitle,Color color){
  return Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:color,
        colorText: kWhite,
        isDismissible: true);
}