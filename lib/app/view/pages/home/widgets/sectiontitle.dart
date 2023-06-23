import 'package:flutter/material.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/customtext.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback function;
  const SectionTitleWidget({super.key, required this.title, required this.function});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          size: 20,
          color: kBlueShade,
        ),
        GestureDetector(
          onTap: function,
          child: const Row(
            children: [
              CustomText(text: "See All"),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      ],
    );
  }
}
