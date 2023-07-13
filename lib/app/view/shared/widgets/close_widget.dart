import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

class CloseWidget extends StatelessWidget {
  final VoidCallback actionfunction;
  const CloseWidget({
    super.key, required this.actionfunction,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 28,
      padding: const EdgeInsets.all(0),
      onPressed: actionfunction,
      //Get.back(),
      style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(kGreylight.withOpacity(0.4))),
      icon: const Icon(
        Icons.keyboard_arrow_left,
        //size: 30,
      ),
    );
  }
}
