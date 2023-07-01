
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/color_constants.dart';

class CloseWidget extends StatelessWidget {
  const CloseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 28,
      padding: const EdgeInsets.all(0),
      onPressed: () => Get.back(),
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              kGreylight.withOpacity(0.4))),
      icon: const Icon(
        Icons.keyboard_arrow_left,
        //size: 30,
      ),
    );
  }
}