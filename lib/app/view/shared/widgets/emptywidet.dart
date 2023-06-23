import 'package:flutter/material.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/images/empty.png"),
          const CustomText(text: "No Item Exists :)"),
        ],
      ),
    );
  }
}
