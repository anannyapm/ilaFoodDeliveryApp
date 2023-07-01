import 'package:flutter/material.dart';

import '../../../../utils/constants/color_constants.dart';

class DotNavigator extends StatelessWidget {
  final bool isActive;
  const DotNavigator({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:const Duration(milliseconds: 300) ,
      height: isActive ? 26 : 8,
      width: 8,
      decoration: BoxDecoration(
          color:isActive? kOrange:kOrange.withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
    );
  }
}