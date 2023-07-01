import 'package:flutter/material.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/custom_text.dart';

class ProfileViewMoreWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback function;
  const ProfileViewMoreWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.function,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: GestureDetector(
        onTap: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                kWidthBox15,
                CustomText(
                  text: text,
                  size: 20,
                )
              ],
            ),
            IconButton(
                onPressed: function,
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: kGreyDark,
                )),
          ],
        ),
      ),
    );
  }
}